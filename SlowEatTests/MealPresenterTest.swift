@testable import SlowEat
import XCTest

class MealPresenterTest: XCTestCase {

    var tracker: SpyTracker!
    var logger: SpyLogger!
    var repository: MockMealRepository!
    var presenter: MealPresenter!
    var view: SpyMealView!

    override func setUp() {
        super.setUp()
        tracker = SpyTracker()
        logger = SpyLogger()
        repository = MockMealRepository()
        view = SpyMealView()
        presenter = MealPresenter(view: view,
                                  tracker: tracker,
                                  logger: logger,
                                  repository: repository)
    }

    func testIfUserHasNoAccountShowError() {
        repository.hasValidAccount = false

        presenter.startMeal()

        XCTAssert(view.showNoAccountErrorCalled)
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

    func testStopMealSavesMeal() {
        var events = [Event]()
        for _ in 1 ... 50 {
            events.append(Event(type: .moving, date: Date()))
            presenter.moving()
            events.append(Event(type: .waiting, date: Date()))
            presenter.waiting()
        }
        let meal = Meal(events: events)

        presenter.stopMeal()

        XCTAssert(repository.saveCalled)
        XCTAssertEqual(meal.events.map { $0.type }, repository.savedMeal.events.map { $0.type })
    }
}
