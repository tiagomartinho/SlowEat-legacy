@testable import SlowEat

class SpyMealRepository: MealRepository {

    var saveCalled = false
    var savedMeal: Meal!

    func save(meal: Meal) {
        saveCalled = true
        savedMeal = meal
    }
}
