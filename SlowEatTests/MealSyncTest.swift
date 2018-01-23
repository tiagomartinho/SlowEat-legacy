@testable import SlowEat
import WatchConnectivity
import XCTest

class WatchKitSession: NSObject, Session, WCSessionDelegate {

    weak var delegate: SessionDelegate?

    var session: WCSession {
        return WCSession.default
    }

    var state: SessionState {
        let isActive = session.activationState == .activated
        return isActive ? .active : .inactive
    }

    func activate() {
        if WCSession.isSupported() {
            session.activate()
        }
    }

    func transfer(file: String) {
        if let path = URL(string: file) {
            session.transferFile(path, metadata: nil)
        }
    }

    func session(_: WCSession, activationDidCompleteWith _: WCSessionActivationState, error _: Error?) {
        delegate?.sessionUpdate(state: state)
    }

    func sessionDidBecomeInactive(_: WCSession) {
        delegate?.sessionUpdate(state: state)
    }

    func sessionDidDeactivate(_: WCSession) {
        delegate?.sessionUpdate(state: state)
    }
}

protocol SessionDelegate: class {
    func sessionUpdate(state: SessionState)
}

protocol Session: class {
    weak var delegate: SessionDelegate? { get set }
    var state: SessionState { get }
    func activate()
    func transfer(file: String)
}

class MealSync: SessionDelegate {

    let session: Session

    var file: String?

    init(session: Session) {
        self.session = session
        session.delegate = self
    }

    func sync(file: String) {
        self.file = file
        if session.state == .active {
            session.transfer(file: file)
        } else {
            session.activate()
        }
    }

    func sessionUpdate(state _: SessionState) {
        if session.state == .active, let file = file {
            sync(file: file)
        }
    }
}

class MockSession: Session {

    var state = SessionState.inactive
    var delegate: SessionDelegate?
    var activateWasCalled = false
    var transferFileWasCalled = false

    var fileToTransfer = ""

    func activate() {
        activateWasCalled = true
    }

    func transfer(file: String) {
        transferFileWasCalled = true
        fileToTransfer = file
    }
}

enum SessionState {
    case inactive, active
}

class MealSyncTest: XCTestCase {

    func testActivateSessionBeforeSync() {
        session.state = .inactive

        sync.sync(file: "")

        XCTAssert(session.activateWasCalled)
    }

    func testTransferFileIfSessionIsActive() {
        session.state = .active

        sync.sync(file: "filename")

        XCTAssert(session.transferFileWasCalled)
        XCTAssertEqual("filename", session.fileToTransfer)
    }

    func testWhenStateChangesToActiveSync() {
        session.state = .inactive
        sync.sync(file: "filename")

        session.state = .active
        sync.sessionUpdate(state: .active)

        XCTAssert(session.transferFileWasCalled)
        XCTAssertEqual("filename", session.fileToTransfer)
    }

    var session: MockSession!
    var sync: MealSync!

    override func setUp() {
        super.setUp()
        session = MockSession()
        sync = MealSync(session: session)
    }
}
