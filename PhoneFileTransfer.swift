class PhoneFileTransfer {

    let session: Session
    let repository: DateRepository
    weak var delegate: PhoneFileTransferDelegate?
    private let lastDateSyncKey = "LastUpdateDate"

    init(session: Session, repository: DateRepository, delegate: PhoneFileTransferDelegate) {
        self.session = session
        self.repository = repository
        self.delegate = delegate
        session.delegate = self
    }

    func sync() {
        if session.isActive {
            sendSyncMessage()
        } else {
            session.activate()
        }
    }

    private func sendSyncMessage() {
        let date = repository.load()
        session.transfer(userInfo: [lastDateSyncKey: date])
    }
}

extension PhoneFileTransfer: SessionDelegate {
    func sessionUpdate(state _: SessionState) {
        sync()
    }

    func didReceive(userInfo _: [String: Any]) {
    }

    func didReceive(file: String) {
        delegate?.didReceive(file: file)
    }
}
