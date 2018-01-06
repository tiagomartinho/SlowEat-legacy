import Foundation

class Event: NSObject, NSCoding {

    let type: EventType
    let date: Date

    init(type: EventType, date: Date) {
        self.type = type
        self.date = date
    }

    public required init?(coder aDecoder: NSCoder) {
        type = EventType(rawValue: aDecoder.decodeObject(forKey: CoderKeys.typeKey.rawValue) as? String ?? "") ?? EventType.moving
        date = aDecoder.decodeObject(forKey: CoderKeys.dateKey.rawValue) as? Date ?? Date()
    }

    open func encode(with aCoder: NSCoder) {
        aCoder.encode(type.rawValue, forKey: CoderKeys.typeKey.rawValue)
        aCoder.encode(date, forKey: CoderKeys.dateKey.rawValue)
    }

    enum CoderKeys: String {
        case typeKey = "TypeKey"
        case dateKey = "DateKey"
    }

    open override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Event {
            return type == object.type && date == object.date
        }
        return false
    }
}
