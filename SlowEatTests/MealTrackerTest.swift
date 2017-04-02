import XCTest

class MealTrackerTest: XCTestCase {

    func testStartTrackerToSaveStartDate() {
        let staticDateProvider = StaticDateProvider()
        let expected = staticDateProvider.currentDate
        let tracker = MealTracker(dateProvider: staticDateProvider)

        tracker.start()

        XCTAssertEqual(expected, tracker.startDate!)
    }
}

class MealTracker {

    let dateProvider: DateProvider

    var startDate: Date?

    init(dateProvider: DateProvider) {
        self.dateProvider = dateProvider
    }

    func start() {
        startDate = dateProvider.currentDate
    }
}

protocol DateProvider {
    var currentDate: Date { get }
}

class StaticDateProvider: DateProvider {
    var currentDate = Date(timeIntervalSince1970: 0)
}
