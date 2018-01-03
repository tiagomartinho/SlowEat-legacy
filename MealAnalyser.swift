class MealAnalyser {
    func analyse(meal: Meal) -> Meal {
        var movingCount = 0
        let processedEvents = meal.events.map { event -> Event in
            let shouldGroupMovingEvent = movingCount > 0 && movingCount < 10
            let processedEvent = shouldGroupMovingEvent ? Event(type: .waiting, date: event.date) : event
            let isMoving = (event.type == .moving)
            movingCount = isMoving ? (movingCount + 1) % 10 : 0
            return processedEvent
        }
        return Meal(events: processedEvents)
    }
}
