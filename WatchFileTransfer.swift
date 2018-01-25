import Foundation

class WatchFileTransfer {

    private let session: Session
    private let repository: DateRepository

    private let lastDateSyncKey = "LastUpdateDate"
    private var file: String?
    private var date: Date?

    init(session: Session, repository: DateRepository) {
        self.session = session
        self.repository = repository
        session.delegate = self
    }

    func sync(file: String, date: Date) {
        self.file = file
        self.date = date
        if session.state == .active && session.isReachable {
            transferFile()
        } else {
            session.activate()
        }
    }

    private func transferFile() {
        guard let lastDateSync = repository.load(),
            let file = file,
            let date = date else {
            return
        }

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
        if session.state == .active, let file = file, let date = date {
            sync(file: file, date: date)
        }
    }
}
