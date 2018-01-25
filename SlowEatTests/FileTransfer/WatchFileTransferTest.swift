@testable import SlowEat
import WatchConnectivity
import XCTest

class WatchFileTransferTest: XCTestCase {

    func testActivateSessionBeforeSync() {
        session.state = .inactive
        session.isReachable = false

        sync.sync(date: Date())

        XCTAssert(session.activateWasCalled)
    }

    func testWhenStateChangesToActiveTransferFile() {
        let date = Date(timeIntervalSince1970: 123)
        session.state = .inactive
        sync.sync(date: date)
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

        sync.sync(date: date)

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testIfLastDateSyncDiffersTransferFile() {
        session.state = .active
        session.isReachable = true
        let date = Date(timeIntervalSince1970: 123)
        repository.date = Date(timeIntervalSince1970: 0)

        sync.sync(date: date)

        XCTAssert(session.transferFileWasCalled)
        XCTAssertEqual(filename, session.fileToTransfer)
    }

    func testDoNotSendMessageIfNotReachable() {
        session.state = .active
        session.isReachable = false

        sync.sync(date: Date())

        XCTAssertFalse(session.sendMessageWasCalled)
    }

    func testDoNotTransferFileIfFileIsInTheListOfPendingFiles() {
        repository.date = Date(timeIntervalSince1970: 0)
        session.state = .active
        session.isReachable = true
        session.mockOutstandingFileTransfers = [filename]

        sync.sync(date: Date())

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testWhenReceivingMessageWithLastDateSyncTransfer() {
        repository.date = Date(timeIntervalSince1970: 0)
        session.state = .active
        session.isReachable = true
        let message = ["LastUpdateDate": Date()]

        sync.didReceive(message: message)

        XCTAssert(session.transferFileWasCalled)
    }

    func testWhenReceivingMessageWithoutLastDateSyncDoNotTransfer() {
        repository.date = Date(timeIntervalSince1970: 0)
        session.state = .active
        session.isReachable = true

        sync.didReceive(message: [:])

        XCTAssertFalse(session.transferFileWasCalled)
    }

    let filename = "filename"
    var session: MockSession!
    var repository: MockDateRepository!
    var sync: WatchFileTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        repository = MockDateRepository()
        sync = WatchFileTransfer(session: session, repository: repository, file: filename)
    }
}
