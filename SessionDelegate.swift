protocol SessionDelegate: class {
    func sessionUpdate(state: SessionState)
    func didReceive(message: [String: Any])
}
