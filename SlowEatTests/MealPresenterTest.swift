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

    class MealPresenter {

        let tracker: Tracker
        let logger: Logger

        init(tracker: Tracker, logger: Logger) {
            self.tracker = tracker
            self.logger = logger
        }

        func startMeal() {
            tracker.start()
            logger.start()
        }
    }

    class SpyTracker: Tracker {

        var startCalled = false

        func start() {
            startCalled = true
        }
    }

    class SpyLogger: Logger {

        var startCalled = false

        func start() {
            startCalled = true
        }
    }
}
