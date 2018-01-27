import WatchConnectivity

class WatchKitSession: NSObject, Session, WCSessionDelegate {

    weak var delegate: SessionDelegate?

    let session = WCSession.default

    var state: SessionState {
        let isActive = session.activationState == .activated
        return isActive ? .active : .inactive
    }

    var outstandingFileTransfers: [String] {
        return session.outstandingFileTransfers.filter {
            $0.isTransferring
        }.map {
            $0.file.fileURL.absoluteString
        }
    }

    var outstandingUserInfoTransfers: [[String: Any]] {
        return session.outstandingUserInfoTransfers.filter {
            $0.isTransferring
        }.map {
            $0.userInfo
        }
    }

    func activate() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }

    func transfer(file: String) {
        if isActive, let path = URL(string: file) {
            session.transferFile(path, metadata: nil)
        }
    }

    func session(_: WCSession, activationDidCompleteWith _: WCSessionActivationState, error _: Error?) {
        delegate?.sessionUpdate(state: state)
    }

    func transfer(userInfo: [String: Any]) {
        guard isActive else { return }
        session.transferUserInfo(userInfo)
    }

    func session(_: WCSession, didReceiveUserInfo userInfo: [String: Any]) {
        delegate?.didReceive(userInfo: userInfo)
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
