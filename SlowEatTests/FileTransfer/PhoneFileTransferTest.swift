@testable import SlowEat
import WatchConnectivity
import XCTest

class PhoneFileTransferTest: XCTestCase {

    func testActivateSessionBeforeSendingMessage() {
        session.setInactive()

        fileTransfer.sync()

        XCTAssert(session.activateWasCalled)
        XCTAssertFalse(session.transferUserInfoWasCalled)
    }

    func testSendMessageWithLastDate() {
        let date = Date()
        repository.date = date
        session.setActive()

        fileTransfer.sync()

        XCTAssertEqual(date, session.userInfoSent["LastUpdateDate"] as? Date)
    }

    func testWhenStateChangesSendMessage() {
        let date = Date()
        repository.date = date

        session.setActive()

        XCTAssertEqual(date, session.userInfoSent["LastUpdateDate"] as? Date)
    }

    func testDelegatesWhenReceivesFile() {
        let filename = "filename"

        fileTransfer.didReceive(file: filename)

        XCTAssert(spyDelegatee.didReceiveFileCalled)
        XCTAssertEqual(filename, spyDelegatee.filename)
    }

    func testDoNotTransferInfoIfIsInTheListOfPendingTransfers() {
        let date = Date()
        repository.date = date
        session.mockOutstandingUserInfoTransfers = [["LastUpdateDate": date] as [String: Any]]
        session.setActive()

        fileTransfer.sync()

        XCTAssertFalse(session.transferUserInfoWasCalled)
    }

    var session: MockSession!
    var repository: MockDateRepository!
    var spyDelegatee: SpyPhoneFileTransferDelegate!
    var fileTransfer: PhoneFileTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        repository = MockDateRepository()
        spyDelegatee = SpyPhoneFileTransferDelegate()
        fileTransfer = PhoneFileTransfer(session: session, repository: repository, delegate: spyDelegatee)
    }
}

class SpyPhoneFileTransferDelegate: PhoneFileTransferDelegate {

    var filename: String!
    var didReceiveFileCalled = false

    func didReceive(file: String) {
        filename = file
        didReceiveFileCalled = true
    }
}
