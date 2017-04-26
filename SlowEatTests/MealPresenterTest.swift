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

    func testStartMealStartsLogger() {
        presenter.startMeal()

        XCTAssert(logger.startCalled)
    }
}