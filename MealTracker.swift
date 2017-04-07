import Foundation

class MealTracker {

    let dateProvider: DateProvider

    var startDate: Date?
    var endDate: Date?

    let biteCount = 0

    var mealTime: TimeInterval? {
        guard let startDate = startDate else { return nil }
        return dateProvider.currentDate.timeIntervalSince(startDate)
    }

    init(dateProvider: DateProvider) {
        self.dateProvider = dateProvider
    }

    func start() {
        startDate = dateProvider.currentDate
    }

    func stop() {
        endDate = dateProvider.currentDate
    }

    func waiting() {
    }
}
