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

    func log(type: EventType) {
        let event = Event(type: type, date: timeTracker.currentDate)
        events.append(event)
    }

    func stop() {
        endDate = timeTracker.currentDate
        timeTracker.stop()
    }
}

extension MealLogger {
    static func build() -> MealLogger {
        let dateProvider = FoundationDateProvider()
        let timeTracker = FoundationTimeTracker(dateProvider: dateProvider)
        return MealLogger(timeTracker: timeTracker)
    }
}
