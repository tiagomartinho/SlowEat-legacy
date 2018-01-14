@testable import SlowEat
import XCTest

class MealCellTest: XCTestCase {

    func testCalculateNoChange() {
        let cell = MealCell(current: slowMeal8BPM, previous: slowMeal8BPM)
        XCTAssertEqual("", cell.change)
        XCTAssertEqual(.clear, cell.color)
    }

    func testCalculatePositiveChange() {
        let cell = MealCell(current: slowMeal8BPM, previous: fastMeal10BPM)
        XCTAssertEqual("-2 bpm (20%)", cell.change)
        XCTAssertEqual(.green, cell.color)
    }

    func testCalculateNegativeChange() {
        let cell = MealCell(current: fastMeal10BPM, previous: slowMeal8BPM)
        XCTAssertEqual("+2 bpm (25%)", cell.change)
        XCTAssertEqual(.red, cell.color)
    }

    var slowMeal8BPM: GradedMeal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] = [0.0, 12.0, 13.0, 18.0, 20.0, 23.0]
        let events = eventsType.enumerated().map {
            Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset]))
        }
        let meal = Meal(events: events)
        return MealAnalyser().analyse(meal: meal)
    }

    var fastMeal10BPM: GradedMeal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] = [0.0, 6.0, 8.0, 9.0, 10.0, 13.0]
        let events = eventsType.enumerated().map {
            Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset]))
        }
        let meal = Meal(events: events)
        return MealAnalyser().analyse(meal: meal)
    }
}
