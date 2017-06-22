protocol Logger {
    func start()
    func stop()
    func log(type: EventType)
    var events: [Event] { get }
}
