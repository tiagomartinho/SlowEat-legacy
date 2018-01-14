import Foundation

class MealsPresenter {

    let view: MealsView

    init(view: MealsView) {
        self.view = view
    }

    func loadMeals() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        let date = dateFormatter.string(from: Date())
        let cells = [MealCell(bpm: "12", date: date, change: "- 12 bpm (2.5%)", color: .green)]
        view.showMeals(cells: cells)
    }
}
