import XCTest

class MealTrackerTest: XCTestCase {

    var staticDateProvider: StaticDateProvider!
    var tracker: MealTracker!

    override func setUp() {
        super.setUp()
        staticDateProvider = StaticDateProvider()
        tracker = MealTracker(dateProvider: staticDateProvider)
    }

    func testStartTrackerToSaveStartDate() {
        let expected = staticDateProvider.currentDate

        tracker.start()

        XCTAssertEqual(expected, tracker.startDate!)
    }

    func testStopTrackerToSaveEndDate() {
        let expected = Date(timeIntervalSince1970: 100)
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
