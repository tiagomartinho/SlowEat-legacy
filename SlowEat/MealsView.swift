import Foundation

protocol MealListView {
    func showNoMeals()
    func showMeals(cells: [MealCell])
}
