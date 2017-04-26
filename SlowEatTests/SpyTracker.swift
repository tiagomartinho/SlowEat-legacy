@testable import SlowEat

class SpyTracker: Tracker {

    var startCalled = false

    func start() {
        startCalled = true
    }
}
