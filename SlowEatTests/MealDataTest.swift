@testable import SlowEat
import XCTest

class MealDataTest: XCTestCase {
    func testSerialization() {
        let originalMeal = MealData(identifier: "someID")
        let data = NSKeyedArchiver.archivedData(withRootObject: originalMeal)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let meal = (try? unarchiver.decodeObject(forKey: "root")) as? MealData
        XCTAssertEqual(originalMeal.identifier, meal?.identifier)
    }

    func testMealSerialization() {
        let meal = Meal(identifier: "someID", events: [])
        let otherMeal = Meal(any: meal.data)
        XCTAssertEqual(meal, otherMeal)
    }
}
