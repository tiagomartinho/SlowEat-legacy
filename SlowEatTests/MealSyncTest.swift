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

    func send(message: [String: Any]) {
        session.sendMessage(message, replyHandler: nil)
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
    func send(message: [String: Any])
}

class MealSync: SessionDelegate {

    let session: Session

    private var file: String?
    private var date: Date?

    init(session: Session) {
        self.session = session
        session.delegate = self
    }

    func sync(file: String, date: Date) {
        self.file = file
        self.date = date
        if session.state == .active {
            session.send(message: ["LastDateSync": date])
//            session.transfer(file: file)
        } else {
            session.activate()
        }
    }

    func sessionUpdate(state _: SessionState) {
        if session.state == .active, let file = file, let date = date {
            sync(file: file, date: date)
        }
    }
}

class MockSession: Session {

    var state = SessionState.inactive
    weak var delegate: SessionDelegate?
    var activateWasCalled = false
    var transferFileWasCalled = false
    var sendMessageWasCalled = false
    var fileToTransfer = ""
    var messageSent: [String: Any] = [:]

    func activate() {
        activateWasCalled = true
    }

    func transfer(file: String) {
        transferFileWasCalled = true
        fileToTransfer = file
    }

    func send(message: [String: Any]) {
        sendMessageWasCalled = true
        messageSent = message
    }
}

enum SessionState {
    case inactive, active
}

class MealSyncTest: XCTestCase {

    func testActivateSessionBeforeSync() {
        session.state = .inactive

        sync.sync(file: "", date: Date())

        XCTAssert(session.activateWasCalled)
    }

    func testWhenStateChangesToActiveAskLastDateSync() {
        let date = Date(timeIntervalSince1970: 123)
        session.state = .inactive
        sync.sync(file: "filename", date: date)

        session.state = .active
        sync.sessionUpdate(state: .active)

        XCTAssert(session.sendMessageWasCalled)
        XCTAssertEqual(date, session.messageSent["LastDateSync"] as? Date ?? Date())
        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testAskLastDateSyncBeforeTransferFile() {
        session.state = .active
        let date = Date(timeIntervalSince1970: 123)

        sync.sync(file: "filename", date: date)

        XCTAssert(session.sendMessageWasCalled)
        XCTAssertEqual(date, session.messageSent["LastDateSync"] as? Date ?? Date())
        XCTAssertFalse(session.transferFileWasCalled)
    }

    var session: MockSession!
    var sync: MealSync!

    override func setUp() {
        super.setUp()
        session = MockSession()
        sync = MealSync(session: session)
    }
}
