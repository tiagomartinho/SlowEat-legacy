import Foundation

class MealTracker {

    var biteCount = 0

    private let timeTracker: TimeTracker
    private var isWaiting = false

    var bitesPerMinute: Int {
        guard let time = mealTime else { return 0 }
        let minutes = time / 60
        guard minutes > 0 else { return 0 }
        return Int(Double(biteCount) / minutes)
    }

    var mealTime: TimeInterval? {
        return timeTracker.currentTime
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

extension MealTracker {
    static func build() -> MealTracker {
        let dateProvider = FoundationDateProvider()
        let timeTracker = FoundationTimeTracker(dateProvider: dateProvider)
        return MealTracker(timeTracker: timeTracker)
    }
}
