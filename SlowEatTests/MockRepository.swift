@testable import SlowEat

class MockMealRepository: MealRepository {

    var saveCalled = false
    var savedMeal: Meal!
    var hasValidAccount = true

    func hasValidAccount(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(hasValidAccount)
    }

    func save(meal: Meal) {
        saveCalled = true
        savedMeal = meal
    }

    func load(completionHandler _: @escaping ([Meal]) -> Void) {
    }
}
