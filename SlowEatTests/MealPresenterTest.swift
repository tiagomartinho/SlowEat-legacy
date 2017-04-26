import XCTest
@testable import SlowEat

class MealPresenterTest: XCTestCase {

    func testStartMealStartsTracker() {
        let tracker = SpyTracker()
        let presenter = MealPresenter(tracker: tracker)

        presenter.startMeal()

        XCTAssert(tracker.startCalled)
    }

    class MealPresenter {

        let tracker: Tracker

        init(tracker: Tracker) {
            self.tracker = tracker
        }

        func startMeal() {
            tracker.start()
        }
    }

    class SpyTracker: Tracker {

        var startCalled = false

        func start() {
            startCalled = true
        }
    }
}
