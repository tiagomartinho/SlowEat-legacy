@testable import SlowEat
import XCTest

class MealTransferTest: XCTestCase {

    func testActivateSessionBeforeSendingMeal() {
        let meal = Meal(identifier: "", events: [])
        session.setInactive()

        mealTransfer.send(meal)

        XCTAssert(session.activateWasCalled)
        XCTAssertFalse(session.transferUserInfoWasCalled)
    }

    func testWhenSessionActivatesTransfer() {
        let meal = Meal(identifier: "", events: [])
        session.setInactive()
        mealTransfer.send(meal)

        session.setActive()

        XCTAssert(session.transferUserInfoWasCalled)
        XCTAssertEqual(meal, session.userInfoSent["Add Meal"] as? Meal)
    }

    func testSendMealIfActive() {
        let meal = Meal(identifier: UUID().uuidString, events: [Event(type: .waiting, date: Date())])
        session.setActive()

        mealTransfer.send(meal)

        XCTAssertEqual(meal, session.userInfoSent["Add Meal"] as? Meal)
    }

    func testNotifyDelegateWhenMealIsReceived() {
        let meal = Meal(identifier: UUID().uuidString, events: [Event(type: .waiting, date: Date())])
        let userInfo = ["Add Meal": meal] as [String: Any]

        mealTransfer.didReceive(userInfo: userInfo)

        XCTAssertEqual(meal, delegatee.meal)
    }

    var session: MockSession!
    var delegatee: SpyMealTransferDelegate!
    var mealTransfer: MealTransfer!

    override func setUp() {
        super.setUp()
        session = MockSession()
        delegatee = SpyMealTransferDelegate()
        mealTransfer = MealTransfer(session: session, delegate: delegatee)
    }
}

class SpyMealTransferDelegate: MealTransferDelegate {

    var meal: Meal!

    func didAddMeal(_ meal: Meal) {
        self.meal = meal
    }
}
