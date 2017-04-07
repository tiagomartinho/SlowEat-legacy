@testable import SlowEat

class SpyTimeTracker: TimeTracker {

    var startDate: Date?
    var endDate: Date?

    var startCalled = false
    var stopCalled = false
    let someTimeInterval: TimeInterval = 123

    var currentTime: TimeInterval? {
        return someTimeInterval
    }

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }
}
