class MealTransfer {

    let session: Session
    weak var delegate: MealTransferDelegate?

    private var meal: Meal?

    init(session: Session, delegate: MealTransferDelegate) {
        self.session = session
        self.delegate = delegate
        session.delegate = self
        session.activate()
    }

    func send(_ meal: Meal) {
        self.meal = meal
        if session.isActive {
            session.transfer(userInfo: ["Add Meal": meal.data])
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
        if let data = userInfo["Add Meal"] as? Data,
            let meal = Meal(data: data) {
            delegate?.didAddMeal(meal)
        }
    }
}

import Foundation

extension Meal {
    var data: Data {
        let mealData = MealData(identifier: identifier)
        return NSKeyedArchiver.archivedData(withRootObject: mealData)
    }

    init?(data: Data) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        guard let mealData = (try? unarchiver.decodeObject(forKey: "root")) as? MealData,
            let identifier = mealData.identifier else { return nil }
        self.identifier = identifier
        events = []
    }
}

class MealData: NSObject, NSCoding {

    var identifier: String?
    var events: [Event]?

    private static let KeyId = "key_identifier"
    private static let KeyEvents = "key_events"

    init(identifier: String) {
        self.identifier = identifier
    }

    required init? (coder aDecoder: NSCoder) {
        identifier = aDecoder.decodeObject(forKey: MealData.KeyId) as? String
//        events = []
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(identifier, forKey: MealData.KeyId)
        // encode events
    }
}
