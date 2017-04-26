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

    class MealLogger {

        var startDate: Date?

        var events = [Event]()

        func start(at date: Date) {
            startDate = date
        }

        func log(event: MealEvent, at date: Date) {
            let event = Event(event: event, date: date)
            events.append(event)
        }
    }

    struct Event {
        let event: MealEvent
        let date: Date
    }

    enum MealEvent {
        case waiting, moving
    }
}
