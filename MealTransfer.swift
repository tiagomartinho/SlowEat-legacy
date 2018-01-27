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
