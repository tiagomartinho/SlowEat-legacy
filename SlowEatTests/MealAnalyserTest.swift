@testable import SlowEat
import XCTest

class MealAnalyserTest: XCTestCase {

    func testGradeEvents() {
        let analyser = MealAnalyser()

        let gradedMeal = analyser.analyse(meal: meal)

        XCTAssertEqual(3, gradedMeal.bites)
    }

    var meal: Meal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] = [0.0, 12.0, 13.0, 18.0, 20.0, 23.0]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }
}
