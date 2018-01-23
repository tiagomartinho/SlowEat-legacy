class MealGrader {
    func grade(meal: Meal) -> GradedMeal {
        var grades = [Grade]()
        guard let date = meal.events.first?.date else {
            return GradedMeal(identifier: meal.identifier, events: meal.events, grades: grades)
        }
        var lastWaitingEvent = Event(type: .waiting, date: date)
        for event in meal.events {
            if event.type == .moving {
                let delta = event.date.timeIntervalSince1970 - lastWaitingEvent.date.timeIntervalSince1970
                grades.append(Grade(delta: delta))
                lastWaitingEvent = Event(type: .waiting, date: event.date)
            } else {
                grades.append(.empty)
            }
        }
        return GradedMeal(identifier: meal.identifier, events: meal.events, grades: grades)
    }
}
