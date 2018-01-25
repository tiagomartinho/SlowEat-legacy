import Foundation
@testable import SlowEat

class MockSession: Session {

    var state = SessionState.inactive
    var isReachable = false
    weak var delegate: SessionDelegate?
    var activateWasCalled = false
    var transferFileWasCalled = false

    func setInactive() {
        state = .inactive
        isReachable = false
    }

    func setActive() {
        state = .active
        isReachable = true
        delegate?.sessionUpdate(state: .active)
    }

    var sendMessageWasCalled = false
    var fileToTransfer = ""
    var messageSent: [String: Any] = [:]
    var lastDateSync: Date!

    var outstandingFileTransfers: [String] {
        return mockOutstandingFileTransfers
    }

    var mockOutstandingFileTransfers: [String] = []

    func activate() {
        activateWasCalled = true
    }

    func transfer(file: String) {
        transferFileWasCalled = true
        fileToTransfer = file
    }

    func send(message: [String: Any], replyHandler: @escaping (([String: Any]) -> Void)) {
        sendMessageWasCalled = true
        messageSent = message
        replyHandler(["LastDateSync": lastDateSync])
    }
}
