import WatchConnectivity

class WatchKitSession: NSObject, Session, WCSessionDelegate {

    weak var delegate: SessionDelegate?

    let session = WCSession.default

    var state: SessionState {
        let isActive = session.activationState == .activated
        return isActive ? .active : .inactive
    }

    var isReachable: Bool {
        return session.isReachable
    }

    var outstandingFileTransfers: [String] {
        return session.outstandingFileTransfers.filter {
            $0.isTransferring
        }.map {
            $0.file.fileURL.absoluteString
        }
    }

    func activate() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }

    func transfer(file: String) {
        if session.activationState == .activated, let path = URL(string: file) {
            session.transferFile(path, metadata: nil)
        }
    }

    func session(_: WCSession, activationDidCompleteWith _: WCSessionActivationState, error _: Error?) {
        delegate?.sessionUpdate(state: state)
    }

    func send(message: [String: Any]) {
        guard isReachable else { return }
        session.sendMessage(message,
                            replyHandler: { _ in
                                print("replyHandler")
                            },
                            errorHandler: { _ in
                                print("error")})
    }

    func session(_: WCSession, didReceiveMessage message: [String: Any]) {
        delegate?.didReceive(message: message)
    }

    func session(_: WCSession, didReceive file: WCSessionFile) {
        delegate?.didReceive(file: file.fileURL.absoluteString)
    }

    #if os(iOS)
        func sessionDidBecomeInactive(_: WCSession) {
            delegate?.sessionUpdate(state: state)
        }

        func sessionDidDeactivate(_: WCSession) {
            delegate?.sessionUpdate(state: state)
        }
    #endif
}
