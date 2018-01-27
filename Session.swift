protocol Session: class {
    weak var delegate: SessionDelegate? { get set }
    var state: SessionState { get }
    var isActive: Bool { get }
    var outstandingFileTransfers: [String] { get }
    func activate()
    func transfer(file: String)
    func send(message: [String: Any])
}

extension Session {
    var isActive: Bool { return state == .active }
}
