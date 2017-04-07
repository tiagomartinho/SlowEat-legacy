import XCTest
@testable import SlowEat

class MealTrackerTest: XCTestCase {

    var timeTracker: SpyTimeTracker!
    var tracker: MealTracker!

    override func setUp() {
        super.setUp()
        timeTracker = SpyTimeTracker()
        tracker = MealTracker(timeTracker: timeTracker)
    }

    func testStartTrackerDelegatesTimeTracking() {
        tracker.start()

        XCTAssert(timeTracker.startCalled)
    }

    func testStopTrackerDelegatesTimeTracking() {
        tracker.stop()

        XCTAssert(timeTracker.stopCalled)
    }

    func testTimeTrackingIsTimeTrackerResponsability() {
        tracker.start()

        let date = tracker.mealTime

        XCTAssertEqual(timeTracker.currentTime, date)
    }

    func testIfUserIsWaitingTheBiteCountDoesNotIncrease() {
        tracker.start()

        for _ in 1...100 { tracker.waiting() }

        XCTAssertEqual(0, tracker.biteCount)
    }

    func testIfUserIsMovingTheBiteCountDoesNotIncrease() {
        tracker.start()

        for _ in 1...100 { tracker.moving() }

        XCTAssertEqual(0, tracker.biteCount)
    }

    func testIfUserIsWaitingAndThenMovesTheBiteCountIncreases() {
        tracker.start()
        for _ in 1...100 { tracker.waiting() }

        tracker.moving()

        XCTAssertEqual(1, tracker.biteCount)
    }

    func testIfUserIsWaitingAndThenIsMovingTheBiteCountIncreasesOnce() {
        tracker.start()
        for _ in 1...100 { tracker.waiting() }

        for _ in 1...100 { tracker.moving() }

        XCTAssertEqual(1, tracker.biteCount)
    }

    func testAlternateMoveAndWaitTracksCorrectBiteCount() {
        tracker.start()

        for _ in 1...100 { tracker.waiting(); tracker.moving() }

        XCTAssertEqual(100, tracker.biteCount)
    }
}
