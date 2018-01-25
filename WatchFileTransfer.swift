import Foundation

class WatchFileTransfer {

    let session: Session

    private let lastDateSyncKey = "LastUpdateDate"
    private var file: String?
    private var date: Date?

    init(session: Session) {
        self.session = session
        session.delegate = self
    }

    func sync(file: String, date: Date) {
        self.file = file
        self.date = date
        if session.state == .active && session.isReachable {
            session.send(message: [lastDateSyncKey: date], replyHandler: transferFile(message:))
        } else {
            session.activate()
        }
    }

    private func transferFile(message: [String: Any]) {
        guard let lastDateSync = message[lastDateSyncKey] as? Date,
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
