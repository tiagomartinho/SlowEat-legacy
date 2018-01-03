class MealAnalyser {
    func analyse(meal: Meal) -> Meal {
        var movingCount = 0
        let processedEvents = meal.events.map { event -> Event in
            let processedEvent = movingCount > 0 && movingCount < 10 ? Event(type: .waiting, date: event.date) : event
            if event.type == .moving {
                movingCount = (movingCount + 1) % 10
            } else {
                movingCount = 0
            }
            return processedEvent
        }
        return Meal(events: processedEvents)
    }
}
