import Foundation

class FoundationTimeTracker: TimeTracker {

    var startDate: Date?
    var endDate: Date?

    var currentDate: Date {
        return dateProvider.currentDate
    }

    var currentTime: TimeInterval? {
        guard let startDate = startDate else { return nil }
        return dateProvider.currentDate.timeIntervalSince(startDate)
    }

    private let dateProvider: DateProvider

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
