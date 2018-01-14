import Foundation

protocol MealsView {
    func showNoMeals()
    func showMeals(cells: [MealCell])
}
