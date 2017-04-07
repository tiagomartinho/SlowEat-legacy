import Foundation

class MealTracker {

    var biteCount = 0

    private let timeTracker: TimeTracker
    private var isWaiting = false

    var mealTime: TimeInterval? {
        return timeTracker.currentTime
    }

    var startDate: Date? {
        return timeTracker.startDate
    }

    var endDate: Date? {
        return timeTracker.endDate
    }

    init(timeTracker: TimeTracker) {
        self.timeTracker = timeTracker
    }

    func start() {
        timeTracker.start()
    }

    func stop() {
        timeTracker.stop()
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
