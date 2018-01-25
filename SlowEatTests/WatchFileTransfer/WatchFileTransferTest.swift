@testable import SlowEat
import WatchConnectivity
import XCTest

class WatchFileTransferTest: XCTestCase {

    func testActivateSessionBeforeSync() {
        session.state = .inactive
        session.isReachable = false

        sync.sync(file: "", date: Date())

        XCTAssert(session.activateWasCalled)
    }

    func testWhenStateChangesToActiveTransferFile() {
        let date = Date(timeIntervalSince1970: 123)
        session.state = .inactive
        sync.sync(file: "filename", date: date)
        repository.date = Date(timeIntervalSince1970: 0)

        session.state = .active
        session.isReachable = true
        sync.sessionUpdate(state: .active)

        XCTAssert(session.transferFileWasCalled)
    }

    func testIfLastDateSyncIsEqualDoNotTransferFile() {
        session.state = .active
        session.isReachable = true
        let date = Date(timeIntervalSince1970: 123)
        repository.date = date

        sync.sync(file: "filename", date: date)

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testIfLastDateSyncDiffersTransferFile() {
        session.state = .active
        session.isReachable = true
        let date = Date(timeIntervalSince1970: 123)
        repository.date = Date(timeIntervalSince1970: 0)

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
        repository.date = Date(timeIntervalSince1970: 0)
        session.state = .active
        session.isReachable = true
        session.mockOutstandingFileTransfers = ["filename"]

        sync.sync(file: "filename", date: Date())

        XCTAssertFalse(session.transferFileWasCalled)
    }

    var session: MockSession!
    var repository: MockDateRepository!
    var sync: WatchFileTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        repository = MockDateRepository()
        sync = WatchFileTransfer(session: session, repository: repository)
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

class MockDateRepository: DateRepository {

    var date: Date!

    func save(date: Date) {
        self.date = date
    }

    func load() -> Date? {
        return date
    }
}
