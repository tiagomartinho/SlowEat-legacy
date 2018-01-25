@testable import SlowEat
import WatchConnectivity
import XCTest

class PhoneFileTransferTest: XCTestCase {

    func testActivateSessionBeforeSync() {
        session.state = .inactive
        session.isReachable = false

        sync.sync(date: Date())

        XCTAssert(session.activateWasCalled)
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
