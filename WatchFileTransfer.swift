import Foundation

class WatchFileTransfer {

    private let session: Session
    private let repository: DateRepository

    private let lastDateSyncKey = "LastUpdateDate"
    private let file: String
    private var date: Date?

    init(session: Session, repository: DateRepository, file: String) {
        self.session = session
        self.repository = repository
        self.file = file
        session.delegate = self
        session.activate()
    }

    private func sync(date: Date) {
        self.date = date
        if session.isActive {
            transferFile()
        } else {
            session.activate()
        }
    }

    private func transferFile() {
        guard let date = date else {
            return
        }

        let lastDateSync = repository.load()
        let fileDateIsTheSame = lastDateSync == date
        let alreadyInTransfer = session.outstandingFileTransfers.contains(file)
        if fileDateIsTheSame || alreadyInTransfer {
            return
        }

        session.transfer(file: file)
    }
}

extension WatchFileTransfer: SessionDelegate {

    func sessionUpdate(state _: SessionState) {
        if session.state == .active, let date = date {
            sync(date: date)
        }
    }

    func didReceive(message: [String: Any]) {
        if let date = message[lastDateSyncKey] as? Date {
            sync(date: date)
        }
    }

    func didReceive(file _: String) {
    }
}
