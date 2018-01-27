import Foundation
@testable import SlowEat

class MockSession: Session {

    var state = SessionState.inactive
    weak var delegate: SessionDelegate?
    var activateWasCalled = false
    var transferFileWasCalled = false

    func setInactive() {
        state = .inactive
    }

    func setActive() {
        state = .active
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

    func send(message: [String: Any]) {
        sendMessageWasCalled = true
        messageSent = message
    }
}
