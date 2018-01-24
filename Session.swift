protocol Session: class {
    weak var delegate: SessionDelegate? { get set }
    var state: SessionState { get }
    var isReachable: Bool { get }
    var outstandingFileTransfers: [String] { get }
    func activate()
    func transfer(file: String)
    func send(message: [String: Any], replyHandler: @escaping (([String: Any]) -> Void))
}