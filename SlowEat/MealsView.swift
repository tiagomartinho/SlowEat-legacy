import Foundation

protocol MealListView: class {
    func showNoMeals()
    func showMeals(cells: [MealCell])
    func showLoading()
    func hideLoading()
}
