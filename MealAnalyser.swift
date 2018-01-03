class MealAnalyser {
    func analyse(meal: Meal) -> Meal {
        var isMoving = false
        let processedEvents = meal.events.map { event -> Event in
            let processedEvent = isMoving ? Event(type: .waiting, date: event.date) : event
            isMoving = (event.type == .moving)
            return processedEvent
        }
        return Meal(events: processedEvents)
    }
}
