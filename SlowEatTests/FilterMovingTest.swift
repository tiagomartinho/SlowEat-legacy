@testable import SlowEat
import XCTest

class FilterMovingTest: XCTestCase {

    func testGroupNearMovingEvents() {
        let filter = FilterMoving()

        let filteredMeal = filter.filter(meal: fiveSecondPaceMeal)

        XCTAssertEqual(fiveSecondPaceMeal.events.count, filteredMeal.events.count)
        XCTAssertEqual(6, filteredMeal.events.filter { $0.type == .moving }.count)
        XCTAssertEqual(.moving, filteredMeal.events[23].type)
        XCTAssertEqual(.waiting, filteredMeal.events[24].type)
        XCTAssertEqual(.moving, filteredMeal.events[54].type)
        XCTAssertEqual(.waiting, filteredMeal.events[55].type)
    }

    func testLeaveSpaceBetweenMovingEventsIfUserIsAlwaysMoving() {
        let filter = FilterMoving()

        let filteredMeal = filter.filter(meal: nonStopMeal)

        XCTAssertEqual(nonStopMeal.events.count, filteredMeal.events.count)
        XCTAssertEqual(3, filteredMeal.events.filter { $0.type == .moving }.count)
        XCTAssertEqual(.moving, filteredMeal.events[9].type)
        XCTAssertEqual(.waiting, filteredMeal.events[12].type)
    }

    func testFiltersCloseMovingEvents() {
        let filter = FilterMoving()

        let filteredMeal = filter.filter(meal: meal)

        XCTAssertEqual(meal.events.count, filteredMeal.events.count)
        let movingEventsCount = filteredMeal.events.filter { $0.type == .moving }.count
        XCTAssertEqual(3, movingEventsCount)
        let waitingEventsCount = filteredMeal.events.filter { $0.type == .waiting }.count
        XCTAssertEqual(filteredMeal.events.count - 3, waitingEventsCount)
    }

    // swiftlint:disable line_length
    var fiveSecondPaceMeal: Meal {
        let eventsType: [EventType] = [.waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting]
        let times: [TimeInterval] = [17.38, 17.86, 18.34, 18.83, 19.31, 19.80, 20.29, 20.77, 21.26, 21.76, 22.24, 22.73, 23.21, 23.70, 24.19, 24.67, 25.16, 25.64, 26.13, 26.62, 27.10, 27.59, 28.08, 28.56, 29.05, 29.54, 30.02, 30.51, 30.99, 31.48, 31.97, 32.45, 32.94, 33.42, 33.91, 34.40, 34.88, 35.37, 35.86, 36.34, 36.83, 37.31, 37.80, 38.29, 38.77, 39.26, 39.75, 40.23, 40.72, 41.20, 41.69, 42.18, 42.66, 43.15, 43.64, 44.12, 44.61, 45.09, 45.58, 46.07, 46.55, 47.04, 47.53, 48.01, 48.50, 48.98, 49.47, 49.96, 50.44, 50.93, 51.43, 51.91, 52.40, 52.89, 53.38, 53.87, 54.35, 54.84, 55.33, 55.82, 56.31, 56.79]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }

    var nonStopMeal: Meal {
        let eventsType: [EventType] = [.moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting]
        let times: [TimeInterval] = [6.79, 7.28, 7.77, 8.26, 8.74, 9.22, 9.71, 10.20, 10.68, 11.17, 11.65, 12.14, 12.63, 13.11, 13.60, 14.09, 14.57, 15.06, 15.54, 16.03, 16.52, 17.00, 17.49, 18.05, 18.47, 18.96, 19.44, 19.94, 20.43, 20.92, 21.41, 21.90, 22.39, 22.88]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }

    var meal: Meal {
        let eventsType: [EventType] = [.waiting, .moving, .waiting, .moving, .waiting, .moving, .waiting, .moving]
        let times: [TimeInterval] = [0.0, 12.0, 13.0, 18.0, 20.0, 23.0, 24.0, 25.0]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }
}
