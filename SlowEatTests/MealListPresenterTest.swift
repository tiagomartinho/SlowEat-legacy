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
        repository.meals = [Meal(events: []), Meal(events: [])]

        presenter.loadMeals()

        XCTAssertEqual("- 12 bpm (2.5%)", view.cells[0].change)
        XCTAssertEqual(Color.green, view.cells[0].color)
        XCTAssertEqual("", view.cells[1].change)
        XCTAssertEqual(Color.clear, view.cells[1].color)
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
    }

    class MockMealRepository: MealRepository {

        var meals = [Meal]()

        func save(meal _: Meal) {
        }

        func load(completionHandler: @escaping ([Meal]) -> Void) {
            completionHandler(meals)
        }
    }
}
