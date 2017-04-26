class MealLogger {

    var startDate: Date?
    var endDate: Date?

    var events = [Event]()

    func start(at date: Date) {
        startDate = date
    }

    func log(event: MealEvent, at date: Date) {
        let event = Event(event: event, date: date)
        events.append(event)
    }

    func stop(at date: Date) {
        endDate = date
    }
}
