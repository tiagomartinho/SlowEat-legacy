@testable import SlowEat
import XCTest

class MealDataTest: XCTestCase {
    func testSerialization() {
        let originalMeal = MealData(identifier: "someID", events: [])
        let data = NSKeyedArchiver.archivedData(withRootObject: originalMeal)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let meal = unarchiver.decodeObject(forKey: "root") as? MealData
        XCTAssertEqual(originalMeal.identifier, meal?.identifier)
    }

    func testMealSerialization() {
        let meal = Meal(identifier: "someID", events: [])
        let otherMeal = Meal(any: meal.data)
        XCTAssertEqual(meal, otherMeal)
    }

    func testEventsSerialization() {
        let event = Event(type: .waiting, date: Date())
        let event2 = Event(type: .moving, date: Date(timeIntervalSince1970: 0))
        let events = [event, event2]
        let meal = Meal(identifier: "", events: events)
        let otherMeal = Meal(any: meal.data)
        XCTAssertEqual(meal.events, otherMeal?.events ?? [])
    }
}
