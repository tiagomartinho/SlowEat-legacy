protocol Session: class {
    weak var delegate: SessionDelegate? { get set }
    var state: SessionState { get }
    var isActive: Bool { get }
    var outstandingFileTransfers: [String] { get }
    var outstandingUserInfoTransfers: [[String: Any]] { get }
    func activate()
    func transfer(file: String)
    func transfer(userInfo: [String: Any])
}

extension Session {
    var isActive: Bool { return state == .active }
}
