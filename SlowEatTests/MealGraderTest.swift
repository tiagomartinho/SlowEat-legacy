import XCTest
@testable import SlowEat

class MealGraderTest: XCTestCase {

    func testGroupNearMovingEvents() {
        let grader = MealGrader()

        let gradedMeal = grader.grade(meal: meal)

        XCTAssertEqual(gradedMeal.events.count, meal.events.count)
        XCTAssertEqual(gradedMeal.grades.count, meal.events.filter { $0.type == .moving }.count)
        XCTAssertEqual(gradedMeal.grades, [.good, .worst, .bad])
    }

    var meal: Meal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] =  [0.0, 12.0, 13.0, 14.0, 15.0, 23.0]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }
}