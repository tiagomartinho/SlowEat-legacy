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

    func send(message: [String: Any], replyHandler: @escaping (([String: Any]) -> Void)) {
        session.sendMessage(message, replyHandler: replyHandler, errorHandler: nil)
    }
}

protocol SessionDelegate: class {
    func sessionUpdate(state: SessionState)
}

protocol Session: class {
    weak var delegate: SessionDelegate? { get set }
    var state: SessionState { get }
    var isReachable: Bool { get }
    var outstandingFileTransfers: [String] { get }
    func activate()
    func transfer(file: String)
    func send(message: [String: Any], replyHandler: @escaping (([String: Any]) -> Void))
}

class WatchFileTransfer {

    let session: Session

    private let lastDateSyncKey = "LastDateSync"
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

class MockSession: Session {

    var state = SessionState.inactive
    var isReachable = false
    weak var delegate: SessionDelegate?
    var activateWasCalled = false
    var transferFileWasCalled = false
    var sendMessageWasCalled = false
    var fileToTransfer = ""
    var messageSent: [String: Any] = [:]
    var lastDateSync: Date!
    var outstandingFileTransfers: [String] {
        return mockOutstandingFileTransfers
    }
    var mockOutstandingFileTransfers: [String] = []

    func activate() {
        activateWasCalled = true
    }

    func transfer(file: String) {
        transferFileWasCalled = true
        fileToTransfer = file
    }

    func send(message: [String: Any], replyHandler: @escaping (([String: Any]) -> Void)) {
        sendMessageWasCalled = true
        messageSent = message
        replyHandler(["LastDateSync": lastDateSync])
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
        session.isReachable = true
        sync.sessionUpdate(state: .active)

        XCTAssert(session.sendMessageWasCalled)
        XCTAssertEqual(date, session.messageSent["LastDateSync"] as? Date ?? Date())
        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testAskLastDateSyncBeforeTransferFile() {
        session.state = .active
        session.isReachable = true
        let date = Date(timeIntervalSince1970: 123)

        sync.sync(file: "filename", date: date)

        XCTAssert(session.sendMessageWasCalled)
        XCTAssertEqual(date, session.messageSent["LastDateSync"] as? Date ?? Date())
        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testIfLastDateSyncIsEqualDoNotTransferFile() {
        session.state = .active
        session.isReachable = true
        let date = Date(timeIntervalSince1970: 123)
        session.lastDateSync = date

        sync.sync(file: "filename", date: date)

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testIfLastDateSyncDiffersTransferFile() {
        session.state = .active
        session.isReachable = true
        let date = Date(timeIntervalSince1970: 123)
        session.lastDateSync = Date(timeIntervalSince1970: 0)

        sync.sync(file: "filename", date: date)

        XCTAssert(session.transferFileWasCalled)
        XCTAssertEqual("filename", session.fileToTransfer)
    }

    func testDoNotSendMessageIfNotReachable() {
        session.state = .active
        session.isReachable = false

        sync.sync(file: "filename", date: Date())

        XCTAssertFalse(session.sendMessageWasCalled)
    }

    func testDoNotTransferFileIfFileIsInTheListOfPendingFiles() {
        session.lastDateSync = Date(timeIntervalSince1970: 0)
        session.state = .active
        session.isReachable = true
        session.mockOutstandingFileTransfers = ["filename"]

        sync.sync(file: "filename", date: Date())

        XCTAssertFalse(session.transferFileWasCalled)
    }

    var session: MockSession!
    var sync: WatchFileTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        sync = WatchFileTransfer(session: session)
    }
}
