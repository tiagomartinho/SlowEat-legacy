@testable import SlowEat

class SpyLogger: Logger {

    var startCalled = false
    var stopCalled = false

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }
}
