import Foundation

class MealTracker {

    var startDate: Date?
    var endDate: Date?
    var biteCount = 0

    private let dateProvider: DateProvider
    private var isWaiting = false

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
        isWaiting = true
    }

    func moving() {
        if isWaiting {
            biteCount += 1
            isWaiting = false
        }
    }
}
