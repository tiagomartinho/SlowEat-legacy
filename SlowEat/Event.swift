import Foundation

class Event: NSObject, NSCoding {

    let type: EventType
    let date: Date

    init(type: EventType, date: Date) {
        self.type = type
        self.date = date
    }

    public required init?(coder aDecoder: NSCoder) {
        type = EventType(rawValue: aDecoder.decodeObject(forKey: CoderKeys.TypeKey.rawValue) as? String ?? "") ?? EventType.moving
        date = aDecoder.decodeObject(forKey: CoderKeys.DateKey.rawValue) as? Date ?? Date()
    }

    open func encode(with aCoder: NSCoder) {
        aCoder.encode(type.rawValue, forKey: CoderKeys.TypeKey.rawValue)
        aCoder.encode(date, forKey: CoderKeys.DateKey.rawValue)
    }

    enum CoderKeys: String {
        case TypeKey = "TypeKey"
        case DateKey = "DateKey"
    }

    override open func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Event {
            return self.type == object.type && self.date == object.date
        }
        return false
    }
}
