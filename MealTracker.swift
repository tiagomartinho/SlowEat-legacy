import Foundation

class MealTracker {

    let dateProvider: DateProvider

    var startDate: Date?
    var endDate: Date?

    init(dateProvider: DateProvider) {
        self.dateProvider = dateProvider
    }

    func start() {
        startDate = dateProvider.currentDate
    }

    func stop() {
        endDate = dateProvider.currentDate
    }
}
