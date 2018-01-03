class MealAnalyser {
    func analyse(meal: Meal) -> Meal {
        var isMoving = false
        var movingCount = 0
        let processedEvents = meal.events.map { event -> Event in
            let processedEvent = movingCount > 0 && movingCount < 10 ? Event(type: .waiting, date: event.date) : event
            isMoving = (event.type == .moving)
            if isMoving {
                movingCount += 1
                if movingCount > 10 {
                    movingCount = 1
                }
            } else {
                movingCount = 0
            }
            return processedEvent
        }
        return Meal(events: processedEvents)
    }
}
