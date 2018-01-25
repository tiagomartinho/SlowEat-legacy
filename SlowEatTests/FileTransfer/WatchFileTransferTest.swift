@testable import SlowEat
import WatchConnectivity
import XCTest

class WatchFileTransferTest: XCTestCase {

    func testActivateSessionBeforeSync() {
        session.setInactive()

        sync.sync(date: Date())

        XCTAssert(session.activateWasCalled)
        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testWhenStateChangesToActiveTransferFile() {
        session.setInactive()
        repository.date = Date(timeIntervalSince1970: 0)
        sync.sync(date: Date(timeIntervalSince1970: 123))

        session.setActive()

        XCTAssert(session.transferFileWasCalled)
    }

    func testIfLastDateSyncIsEqualDoNotTransferFile() {
        session.setActive()
        let date = Date(timeIntervalSince1970: 123)
        repository.date = date

        sync.sync(date: date)

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testIfLastDateSyncDiffersTransferFile() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)

        sync.sync(date: Date(timeIntervalSince1970: 123))

        XCTAssert(session.transferFileWasCalled)
        XCTAssertEqual(filename, session.fileToTransfer)
    }

    func testDoNotTransferFileIfFileIsInTheListOfPendingFiles() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)
        session.mockOutstandingFileTransfers = [filename]

        sync.sync(date: Date(timeIntervalSince1970: 123))

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testWhenReceivingMessageWithLastDateSyncTransfer() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)
        let message = ["LastUpdateDate": Date(timeIntervalSince1970: 123)]

        sync.didReceive(message: message)

        XCTAssert(session.transferFileWasCalled)
    }

    func testWhenReceivingMessageWithoutLastDateSyncDoNotTransfer() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)

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
