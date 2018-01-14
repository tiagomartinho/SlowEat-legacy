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
                        cells.append(MealCell(bpm: "\(meal.bpm)",
                                              date: meal.startDate.short,
                                              change: "",
                                              color: .clear))
                    } else {
                        cells.append(MealCell(bpm: "\(meal.bpm)",
                                              date: meal.startDate.short,
                                              change: "- 12 bpm (2.5%)",
                                              color: .green))
                    }
                }
                self.view?.showMeals(cells: cells)
            }
        }
    }
}
