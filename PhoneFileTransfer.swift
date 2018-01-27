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
        let dateInfoTransfers = session.outstandingUserInfoTransfers.filter { $0.keys.contains(lastDateSyncKey) }
        let alreadyInTransfer = !dateInfoTransfers.isEmpty
        if alreadyInTransfer { return }
        let date = repository.load()
        let userInfo = [lastDateSyncKey: date] as [String: Any]
        session.transfer(userInfo: userInfo)
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
