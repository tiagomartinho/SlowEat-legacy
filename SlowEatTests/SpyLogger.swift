@testable import SlowEat

class SpyLogger: Logger {

    var startCalled = false

    func start() {
        startCalled = true
    }
}
