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

    func startSync() {
        if session.isActiveAndReachable {
            sendMessage()
        } else {
            session.activate()
        }
    }

    private func sendMessage() {
        let date = repository.load()
        session.send(message: [lastDateSyncKey: date])
    }
}

extension PhoneFileTransfer: SessionDelegate {
    func sessionUpdate(state _: SessionState) {
        if session.isActiveAndReachable {
            startSync()
        }
    }

    func didReceive(message _: [String: Any]) {
    }

    func didReceive(file: String) {
        delegate?.didReceive(file: file)
    }
}