import Foundation

class FoundationTimeTracker: TimeTracker {

    var startDate: Date?
    var endDate: Date?

    private let dateProvider: DateProvider

    var currentTime: TimeInterval? {
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
}
