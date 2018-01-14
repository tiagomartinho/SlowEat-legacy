import Foundation

class MealListPresenter {

    let view: MealsView

    init(view: MealsView) {
        self.view = view
    }

    func loadMeals() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        let date = dateFormatter.string(from: meal.startDate)
        let cells = [MealCell(bpm: "\(meal.bpm)", date: date, change: "- 12 bpm (2.5%)", color: .green)]
        view.showMeals(cells: cells)
    }

    // swiftlint:disable line_length
    var meal: GradedMeal {
        let eventsType: [EventType] = [.waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting]
        let times: [TimeInterval] = [17.38, 17.86, 18.34, 18.83, 19.31, 19.80, 20.29, 20.77, 21.26, 21.76, 22.24, 22.73, 23.21, 23.70, 24.19, 24.67, 25.16, 25.64, 26.13, 26.62, 27.10, 27.59, 28.08, 28.56, 29.05, 29.54, 30.02, 30.51, 30.99, 31.48, 31.97, 32.45, 32.94, 33.42, 33.91, 34.40, 34.88, 35.37, 35.86, 36.34, 36.83, 37.31, 37.80, 38.29, 38.77, 39.26, 39.75, 40.23, 40.72, 41.20, 41.69, 42.18, 42.66, 43.15, 43.64, 44.12, 44.61, 45.09, 45.58, 46.07, 46.55, 47.04, 47.53, 48.01, 48.50, 48.98, 49.47, 49.96, 50.44, 50.93, 51.43, 51.91, 52.40, 52.89, 53.38, 53.87, 54.35, 54.84, 55.33, 55.82, 56.31, 56.79]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        return MealAnalyser().analyse(meal: Meal(events: events))
    }
}
