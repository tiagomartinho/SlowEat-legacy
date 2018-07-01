import Foundation

class MealData: NSObject, NSCoding {

    var identifier: String?
    var events: [EventData]?

    private static let KeyId = "key_identifier"
    private static let KeyEvents = "key_events"

    init(identifier: String, events: [EventData]) {
        self.identifier = identifier
        self.events = events
    }

    required init? (coder aDecoder: NSCoder) {
        identifier = aDecoder.decodeObject(forKey: MealData.KeyId) as? String
        events = aDecoder.decodeObject(forKey: MealData.KeyEvents) as? [EventData]
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(identifier, forKey: MealData.KeyId)
        aCoder.encode(events, forKey: MealData.KeyEvents)
    }
}

class EventData: NSObject, NSCoding {

    var event: Event?

    private static let KeyEventType = "key_event_type"
    private static let KeyDate = "key_date"

    init(event: Event) {
        self.event = event
    }

    required init? (coder aDecoder: NSCoder) {
        guard let eventTypeRaw = aDecoder.decodeObject(forKey: EventData.KeyEventType) as? String,
            let date = aDecoder.decodeObject(forKey: EventData.KeyDate) as? Date,
            let type = EventType(rawValue: eventTypeRaw) else {
            return nil
        }
        event = Event(type: type, date: date)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(event?.type.rawValue, forKey: EventData.KeyEventType)
        aCoder.encode(event?.date, forKey: EventData.KeyDate)
    }
}

extension Meal {
    var data: Data {
        let mealData = MealData(identifier: identifier, events: events.map(EventData.init))
        NSKeyedArchiver.setClassName("MealData", for: MealData.self)
        NSKeyedArchiver.setClassName("EventData", for: EventData.self)
        return NSKeyedArchiver.archivedData(withRootObject: mealData)
    }

    init?(any: Any?) {
        guard let data = any as? Data else {
            return nil
        }
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        NSKeyedUnarchiver.setClass(MealData.self, forClassName: "MealData")
        NSKeyedUnarchiver.setClass(EventData.self, forClassName: "EventData")
        guard let mealData = unarchiver.decodeObject(forKey: "root") as? MealData,
            let identifier = mealData.identifier,
            let events = mealData.events else {
            return nil
        }
        self.identifier = identifier
        self.events = events.compactMap { $0.event }
    }
}
