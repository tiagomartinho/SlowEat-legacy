import XCTest

class MealTrackerTest: XCTestCase {

    func testStartTrackerToSaveStartDate() {
        let staticDateProvider = StaticDateProvider()
        let expected = staticDateProvider.currentDate
        let tracker = MealTracker(dateProvider: staticDateProvider)

        tracker.start()

        XCTAssertEqual(expected, tracker.startDate!)
    }

    func testStopTrackerToSaveEndDate() {
        let staticDateProvider = StaticDateProvider()
        let expected = Date(timeIntervalSince1970: 100)
        let tracker = MealTracker(dateProvider: staticDateProvider)
        tracker.start()
        staticDateProvider.currentDate = expected

        tracker.stop()

        XCTAssertEqual(expected, tracker.endDate!)
    }
}

class MealTracker {

    let dateProvider: DateProvider

    var startDate: Date?
    var endDate: Date?

    init(dateProvider: DateProvider) {
        self.dateProvider = dateProvider
    }

    func start() {
        startDate = dateProvider.currentDate
    }

    func stop() {
        endDate = dateProvider.currentDate
    }
}

protocol DateProvider {
    var currentDate: Date { get }
}

class StaticDateProvider: DateProvider {
    var currentDate = Date(timeIntervalSince1970: 0)
}
