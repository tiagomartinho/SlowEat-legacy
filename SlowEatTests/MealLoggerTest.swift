import XCTest
@testable import SlowEat

class MealLoggerTest: XCTestCase {

    func testLoggingOneEvent() {
        let date = Date()
        let logger = MealLogger()

        logger.log(event: .waiting, at: date)

        XCTAssertEqual(1, logger.events.count)
    }

    func testStartLoggingSavesStartDate() {
        let date = Date()
        let logger = MealLogger()

        logger.start(at: date)

        XCTAssertEqual(date, logger.startDate)
    }

    func testStopLoggingSavesEndDate() {
        let date = Date()
        let logger = MealLogger()

        logger.stop(at: date)

        XCTAssertEqual(date, logger.endDate)
    }
}
