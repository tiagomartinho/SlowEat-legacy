import XCTest
@testable import SlowEat

class TimeTrackerTest: XCTestCase {

    var staticDateProvider: StaticDateProvider!
    var tracker: TimeTracker!

    override func setUp() {
        super.setUp()
        staticDateProvider = StaticDateProvider()
        tracker = TimeTracker(dateProvider: staticDateProvider)
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

    func testTrackerHasMealTime() {
        let currentDate = Date(timeIntervalSince1970: 100)
        let expected = currentDate.timeIntervalSince(staticDateProvider.currentDate)
        tracker.start()
        staticDateProvider.currentDate = currentDate

        let date = tracker.currentTime
        
        XCTAssertEqual(expected, date)
    }
}
