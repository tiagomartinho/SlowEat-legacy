import Foundation

class MealListPresenter {

    weak var view: MealListView?
    let repository: MealRepository

    init(view: MealListView, repository: MealRepository) {
        self.view = view
        self.repository = repository
    }

    func loadMeals() {
        view?.showLoading()
        repository.hasValidAccount { hasValidAccount in
            if hasValidAccount {
                self.load()
            } else {
                self.view?.hideLoading()
                self.view?.showNoAccountError()
            }
        }
    }

    private func load() {
        repository.load { meals in
            self.view?.hideLoading()
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
