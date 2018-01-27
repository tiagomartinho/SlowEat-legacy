protocol SessionDelegate: class {
    func sessionUpdate(state: SessionState)
    func didReceive(userInfo: [String: Any])
}
