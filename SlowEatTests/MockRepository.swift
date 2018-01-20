import Foundation
@testable import SlowEat

class MockMealRepository: MealRepository {

    var saveCalled = false
    var savedMeal: Meal!
    var hasValidAccount = true

    var uniqueID: String { return UUID().uuidString }

    func hasValidAccount(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(hasValidAccount)
    }

    func save(meal: Meal) {
        saveCalled = true
        savedMeal = meal
    }

    func load(completionHandler _: @escaping ([Meal]) -> Void) {
    }

    func delete(with _: String) {
    }

    func deleteAll() {
    }
}
