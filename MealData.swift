import Foundation

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

extension Meal {
    var data: Data {
        let mealData = MealData(identifier: identifier)
        return NSKeyedArchiver.archivedData(withRootObject: mealData)
    }

    init?(data: Any) {
        guard let data = data as? Data else { return nil }
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        guard let mealData = (try? unarchiver.decodeObject(forKey: "root")) as? MealData,
            let identifier = mealData.identifier else { return nil }
        self.identifier = identifier
        events = []
    }
}
