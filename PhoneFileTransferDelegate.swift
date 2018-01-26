protocol PhoneFileTransferDelegate: class {
    func didReceive(file: String)
    func notReachable()
}
