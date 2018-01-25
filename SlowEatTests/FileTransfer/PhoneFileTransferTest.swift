@testable import SlowEat
import WatchConnectivity
import XCTest

class PhoneFileTransfer {

    let session: Session
    let repository: DateRepository
    private let lastDateSyncKey = "LastUpdateDate"

    init(session: Session, repository: DateRepository) {
        self.session = session
        self.repository = repository
        session.delegate = self
    }

    func startSync() {
        if session.isActiveAndReachable {
            sendMessage()
        } else {
            session.activate()
        }
    }

    private func sendMessage() {
        let date = repository.load()
        session.send(message: [lastDateSyncKey: date])
    }
}

extension PhoneFileTransfer: SessionDelegate {
    func sessionUpdate(state _: SessionState) {
        if session.isActiveAndReachable {
            startSync()
        }
    }

    func didReceive(message _: [String: Any]) {
    }
}

class PhoneFileTransferTest: XCTestCase {

    func testActivateSessionBeforeSendingMessage() {
        session.setInactive()

        fileTransfer.startSync()

        XCTAssert(session.activateWasCalled)
        XCTAssertFalse(session.sendMessageWasCalled)
    }

    func testDoNotSendMessageIfNotReachable() {
        session.state = .active
        session.isReachable = false

        fileTransfer.startSync()

        XCTAssert(session.activateWasCalled)
        XCTAssertFalse(session.sendMessageWasCalled)
    }

    func testSendMessageWithLastDate() {
        let date = Date()
        repository.date = date
        session.setActive()

        fileTransfer.startSync()

        XCTAssertEqual(date, session.messageSent["LastUpdateDate"] as? Date)
    }

    func testWhenStateChangesSendMessage() {
        let date = Date()
        repository.date = date

        session.setActive()

        XCTAssertEqual(date, session.messageSent["LastUpdateDate"] as? Date)
    }

    var session: MockSession!
    var repository: MockDateRepository!
    var fileTransfer: PhoneFileTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        repository = MockDateRepository()
        fileTransfer = PhoneFileTransfer(session: session, repository: repository)
    }
}
