import Foundation

class MealListPresenter {

    weak var view: MealListView?
    let repository: MealRepository

    init(view: MealListView, repository: MealRepository) {
        self.view = view
        self.repository = repository
    }

    func loadMeals() {
        repository.load { meals in
            if meals.isEmpty {
                self.view?.showNoMeals()
            } else {
                var cells = [MealCell]()
                for (index, rawMeal) in meals.enumerated() {
                    let meal = MealAnalyser().analyse(meal: rawMeal)
                    let isLastMeal = index == (meals.count - 1)
                    if isLastMeal {
                        cells.append(MealCell(gradedMeal: meal))
                    } else {
                        let previous = MealAnalyser().analyse(meal: meals[index + 1])
                        cells.append(MealCell(current: meal, previous: previous))
                    }
                }
                self.view?.showMeals(cells: cells)
            }
        }
    }
}
