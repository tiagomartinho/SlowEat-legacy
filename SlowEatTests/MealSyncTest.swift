@testable import SlowEat
import WatchConnectivity
import XCTest

class WatchKitSession: Session {

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
}

protocol Session: class {
    var state: SessionState { get }
    func activate()
    func transfer(file: String)
}

class MealSync {

    weak var session: Session?

    init(session: Session) {
        self.session = session
    }

    func sync(file: String) {
        if session?.state == .active {
            session?.transfer(file: file)
        } else {
            session?.activate()
        }
    }
}

class MockSession: Session {

    var state = SessionState.inactive

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

    var session: MockSession!
    var sync: MealSync!

    override func setUp() {
        super.setUp()
        session = MockSession()
        sync = MealSync(session: session)
    }
}
