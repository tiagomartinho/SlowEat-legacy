@testable import SlowEat

class SpyLogger: Logger {

    var startCalled = false
    var stopCalled = false
    var lastLoggedEvent: EventType!

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }

    func log(type: EventType) {
        lastLoggedEvent = type
    }
}
