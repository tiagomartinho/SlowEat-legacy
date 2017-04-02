import XCTest
@testable import SlowEat

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
