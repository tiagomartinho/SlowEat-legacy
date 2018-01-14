import Foundation

class InMemoryMealRepository: MealRepository {

    var meals = [Meal]()

    func save(meal: Meal) {
        meals.append(meal)
    }

    func load(completionHandler: @escaping ([Meal]) -> Void) {
        completionHandler(meals)
    }
}
