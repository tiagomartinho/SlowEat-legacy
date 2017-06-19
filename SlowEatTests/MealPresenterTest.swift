import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    var tracker: SpyTracker!
    var logger: SpyLogger!
    var presenter: MealPresenter!

    override func setUp() {
        super.setUp()
        tracker = SpyTracker()
        logger = SpyLogger()
        presenter = MealPresenter(tracker: tracker, logger: logger)
    }

    func testStartMealStartsTracker() {
        presenter.startMeal()

        XCTAssert(tracker.startCalled)
    }

    func testWaitingEventNotifiesTracker() {
        presenter.waiting()

        XCTAssert(tracker.waitingCalled)
    }

    func testMovingEventNotifiesTracker() {
        presenter.moving()

        XCTAssert(tracker.movingCalled)
    }

    func testStopMealStopsTracker() {
        presenter.stopMeal()

        XCTAssert(tracker.stopCalled)
    }

    func testStartMealStartsLogger() {
        presenter.startMeal()

        XCTAssert(logger.startCalled)
    }

    func testWaitingEventNotifiesLogger() {
        presenter.waiting()

        XCTAssertEqual(.waiting, logger.lastLoggedEvent)
    }

    func testMovingEventNotifiesLogger() {
        presenter.moving()

        XCTAssertEqual(.moving, logger.lastLoggedEvent)
    }

    func testStopMealStopsLogger() {
        presenter.stopMeal()

        XCTAssert(logger.stopCalled)
    }
}
