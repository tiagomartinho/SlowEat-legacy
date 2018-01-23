class FilterMoving {
    func filter(meal: Meal) -> Meal {
        let timeInterval = 4.0
        guard var lastMovingEvent = meal.events.first else { return Meal(identifier: meal.identifier, events: []) }
        let processedEvents = meal.events.map { event -> Event in
            let delta = event.date.timeIntervalSince1970 - lastMovingEvent.date.timeIntervalSince1970
            let shouldGroupMovingEvent = delta < timeInterval && delta != 0.0
            let processedEvent = shouldGroupMovingEvent ? Event(type: .waiting, date: event.date) : event
            let isMoving = (event.type == .moving)
            if isMoving && delta > timeInterval {
                lastMovingEvent = event
            }
            return processedEvent
        }
        return Meal(identifier: meal.identifier, events: processedEvents)
    }
}
