@testable import SlowEat
import WatchConnectivity
import XCTest

class WatchFileTransferTest: XCTestCase {

    func testActivateSessionBeforeTransfer() {
        session.setInactive()

        send(with: Date())

        XCTAssert(session.activateWasCalled)
        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testWhenStateChangesToActiveTransferFile() {
        session.setInactive()
        repository.date = Date(timeIntervalSince1970: 0)
        send(with: Date(timeIntervalSince1970: 123))

        session.setActive()

        XCTAssert(session.transferFileWasCalled)
    }

    func testIfLastDateSyncIsEqualDoNotTransferFile() {
        session.setActive()
        let date = Date(timeIntervalSince1970: 123)
        repository.date = date

        send(with: date)

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testIfLastDateSyncDiffersTransferFile() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)

        send(with: Date(timeIntervalSince1970: 123))

        XCTAssert(session.transferFileWasCalled)
        XCTAssertEqual(filename, session.fileToTransfer)
    }

    func testDoNotTransferFileIfFileIsInTheListOfPendingFiles() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)
        session.mockOutstandingFileTransfers = [filename]

        send(with: Date(timeIntervalSince1970: 123))

        XCTAssertFalse(session.transferFileWasCalled)
    }

    func testWhenReceivingMessageWithoutLastDateSyncDoNotTransfer() {
        session.setActive()
        repository.date = Date(timeIntervalSince1970: 0)

        fileTransfer.didReceive(message: [:])

        XCTAssertFalse(session.transferFileWasCalled)
    }

    private func send(with date: Date) {
        let message = ["LastUpdateDate": date]
        fileTransfer.didReceive(message: message)
    }

    let filename = "filename"
    var session: MockSession!
    var repository: MockDateRepository!
    var fileTransfer: WatchFileTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        repository = MockDateRepository()
        fileTransfer = WatchFileTransfer(session: session, repository: repository, file: filename)
    }
}
