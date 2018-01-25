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
    }

    func startSync() {
        let date = repository.load()
        session.send(message: [lastDateSyncKey: date])
    }
}

class PhoneFileTransferTest: XCTestCase {

    func testSendMessageWithLastDate() {
        session.setActive()
        let date = Date()
        repository.date = date

        fileTransfer.startSync()

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