import XCTest
@testable import SlowEat

class MealLoggerTest: XCTestCase {

    var timeTracker: SpyTimeTracker!
    var logger: MealLogger!

    override func setUp() {
        super.setUp()
        timeTracker = SpyTimeTracker()
        logger = MealLogger(timeTracker: timeTracker)
    }

    func testLoggingOneEvent() {
        logger.log(type: .waiting)

        XCTAssertEqual(1, logger.events.count)
    }

    func testLoggingSavesTimeTrackerCurrentTime() {
        let date = Date(timeIntervalSince1970: 123)
        timeTracker.currentDate = date

        logger.log(type: .waiting)

        XCTAssertEqual(date, logger.events.first!.date)
    }

    func testStartTrackerDelegatesTimeTracking() {
        logger.start()

        XCTAssert(timeTracker.startCalled)
    }

    func testTimeTrackingIsTimeTrackerResponsability() {
        let date = Date()

        timeTracker.startDate = date

        XCTAssertEqual(date, logger.startDate)
    }

    func testStopLoggingSavesEndDate() {
        let date = Date()
        timeTracker.currentDate = date

        logger.stop()

        XCTAssertEqual(date, logger.endDate)
    }
}
