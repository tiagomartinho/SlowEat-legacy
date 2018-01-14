import Foundation

class InMemoryMealRepository: MealRepository {

    var meals: [Meal] = {
        var meals = [Meal]()
        for _ in 1 ... 100 {
            meals.append(InMemoryMealRepository.randomMeal())
        }
        return meals
    }()

    func save(meal: Meal) {
        meals.append(meal)
    }

    func load(completionHandler: @escaping ([Meal]) -> Void) {
        completionHandler(meals)
    }

    static func randomMeal() -> Meal {
        var eventsType = [EventType]()
        var times = [TimeInterval]()
        var previousTime = 0.0
        for _ in 1 ... 100 {
            eventsType.append((arc4random_uniform(2) == 0) ? .waiting : .moving)
            previousTime += 1 + Double(arc4random_uniform(3))
            times.append(previousTime)
        }
        let events = eventsType.enumerated().map {
            Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset]))
        }
        let meal = Meal(events: events)
        return meal
    }
}
