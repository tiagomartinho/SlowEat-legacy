@testable import SlowEat

class SpyTracker: Tracker {

    var startCalled = false
    var stopCalled = false

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }
}
