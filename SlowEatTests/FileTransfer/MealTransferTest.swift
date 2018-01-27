@testable import SlowEat
import XCTest

class MealTransfer {

    let session: Session
    weak var delegate: MealTransferDelegate?

    private var meal: Meal?

    init(session: Session, delegate: MealTransferDelegate) {
        self.session = session
        self.delegate = delegate
        session.delegate = self
    }

    func send(_ meal: Meal) {
        self.meal = meal
        if session.isActive {
            session.transfer(userInfo: ["Add Meal": meal])
            self.meal = nil
        } else {
            session.activate()
        }
    }
}

extension MealTransfer: SessionDelegate {

    func sessionUpdate(state _: SessionState) {
        if let meal = meal {
            send(meal)
        }
    }

    func didReceive(userInfo: [String: Any]) {
        if let meal = userInfo["Add Meal"] as? Meal {
            delegate?.didAddMeal(meal)
        }
    }
}

protocol MealTransferDelegate: class {
    func didAddMeal(_ meal: Meal)
}

class SpyMealTransferDelegate: MealTransferDelegate {

    var meal: Meal!

    func didAddMeal(_ meal: Meal) {
        self.meal = meal
    }
}

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
