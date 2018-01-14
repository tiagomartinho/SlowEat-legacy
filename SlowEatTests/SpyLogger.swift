import Foundation
@testable import SlowEat

class SpyLogger: Logger {

    var startCalled = false
    var stopCalled = false
    var lastLoggedEvent: EventType!
    var events = [Event]()

    func start() {
        startCalled = true
    }

    func stop() {
        stopCalled = true
    }

    func log(type: EventType) {
        lastLoggedEvent = type
        events.append(Event(type: type, date: Date()))
    }
}
