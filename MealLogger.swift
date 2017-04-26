class MealLogger: Logger {

    var startDate: Date? { return timeTracker.startDate }
    var endDate: Date?
    var events = [Event]()

    private let timeTracker: TimeTracker

    init(timeTracker: TimeTracker) {
        self.timeTracker = timeTracker
    }

    func start() {
        timeTracker.start()
    }

    func log(event: MealEvent, at date: Date) {
        let event = Event(event: event, date: date)
        events.append(event)
    }

    func stop(at date: Date) {
        endDate = date
    }
}
