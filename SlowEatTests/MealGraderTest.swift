import XCTest
@testable import SlowEat

class MealGraderTest: XCTestCase {

    func testGroupNearMovingEvents() {
        let grader = MealGrader()

        _ = grader.grade(meal: meal)

    }

    var meal: Meal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] =  [0.0, 12.0, 13.0, 14.0, 15.0, 23.0]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }
}

class MealGrader {
    func grade(meal: Meal) -> Meal {
        var lastWaitingEvent = Event(type: .waiting, date: meal.events.first!.date)
        for event in meal.events {
            if event.type == .moving {
                let delta = event.date.timeIntervalSince1970 - lastWaitingEvent.date.timeIntervalSince1970
                let grade = Grade(delta: delta)
                lastWaitingEvent = Event(type: .waiting, date: event.date)
            }
        }
        return meal
    }
}

enum Grade: String {

    case good, bad, worst

    init?(delta: Double) {
        switch delta {
        case Grade.worst.range:
            self = .worst
        case Grade.bad.range:
            self = .bad
        case Grade.good.range:
            self = .good
        default:
            return nil
        }
    }

    private var range: Range<Double> {
        switch self {
        case .worst:
            return 0.0..<5.0
        case .bad:
            return 5.0..<10.0
        case .good:
            return 10.0..<Double.greatestFiniteMagnitude
        }
    }
}
