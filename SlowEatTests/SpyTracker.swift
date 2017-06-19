@testable import SlowEat

class SpyTracker: Tracker {

    var startCalled = false
    var stopCalled = false
    var waitingCalled = false

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }

    func waiting() {
        waitingCalled = true
    }
}
