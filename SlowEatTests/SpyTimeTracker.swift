@testable import SlowEat

class SpyTimeTracker: TimeTracker {

    var startDate: Date?
    var endDate: Date?

    var startCalled = false
    var stopCalled = false
    var trackerCurrentTime: TimeInterval = 123

    var currentTime: TimeInterval? {
        return trackerCurrentTime
    }

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }
}
