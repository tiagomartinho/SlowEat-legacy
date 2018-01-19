@testable import SlowEat
import XCTest

class MealListPresenterTest: XCTestCase {

    var presenter: MealListPresenter!
    var repository: MockMealRepository!
    var view: SpyMealListView!

    override func setUp() {
        super.setUp()
        view = SpyMealListView()
        repository = MockMealRepository()
        presenter = MealListPresenter(view: view, repository: repository)
    }

    func testEmptyRepositoryShowNoMeal() {
        repository.meals = []

        presenter.loadMeals()

        XCTAssert(view.showNoMealsCalled)
        XCTAssertFalse(view.showMealsCalled)
    }

    func testWithoutEmptyRepositoryShowMeals() {
        repository.meals = [Meal(events: [])]

        presenter.loadMeals()

        XCTAssertFalse(view.showNoMealsCalled)
        XCTAssert(view.showMealsCalled)
    }

    func testWithOneMealDoNotShowChange() {
        repository.meals = [Meal(events: [])]

        presenter.loadMeals()

        XCTAssertEqual("", view.cells.first!.change)
        XCTAssertEqual(Color.clear, view.cells.first!.color)
    }

    func testWithTwoMealsShowChangeForLater() {
        repository.meals = [slowMeal8BPM, fastMeal10BPM]

        presenter.loadMeals()

        XCTAssertEqual("-2 bpm (20%)", view.cells[0].change)
        XCTAssertEqual(Color.green, view.cells[0].color)
        XCTAssertEqual("", view.cells[1].change)
        XCTAssertEqual(Color.clear, view.cells[1].color)
    }

    func testWithThreeMeals() {
        repository.meals = [fastMeal10BPM, slowMeal8BPM, fastMeal10BPM]

        presenter.loadMeals()

        XCTAssertEqual("+2 bpm (25%)", view.cells[0].change)
        XCTAssertEqual(Color.red, view.cells[0].color)
        XCTAssertEqual("-2 bpm (20%)", view.cells[1].change)
        XCTAssertEqual(Color.green, view.cells[1].color)
        XCTAssertEqual("", view.cells[2].change)
        XCTAssertEqual(Color.clear, view.cells[2].color)
    }

    class SpyMealListView: MealListView {

        var cells: [MealCell]!
        var showNoMealsCalled = false
        var showMealsCalled = false

        func showNoMeals() {
            showNoMealsCalled = true
        }

        func showMeals(cells: [MealCell]) {
            showMealsCalled = true
            self.cells = cells
        }

        func showLoading() {
        }

        func hideLoading() {
        }
    }

    class MockMealRepository: MealRepository {

        var meals = [Meal]()

        func hasValidAccount(completionHandler: @escaping (Bool) -> Void) {
            completionHandler(true)
        }

        func save(meal _: Meal) {
        }

        func load(completionHandler: @escaping ([Meal]) -> Void) {
            completionHandler(meals)
        }
    }

    var slowMeal8BPM: Meal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] = [0.0, 12.0, 13.0, 18.0, 20.0, 23.0]
        let events = eventsType.enumerated().map {
            Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset]))
        }
        return Meal(events: events)
    }

    var fastMeal10BPM: Meal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] = [0.0, 6.0, 8.0, 9.0, 10.0, 13.0]
        let events = eventsType.enumerated().map {
            Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset]))
        }
        return Meal(events: events)
    }
}
