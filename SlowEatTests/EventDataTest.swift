@testable import SlowEat
import XCTest

class EventDataTest: XCTestCase {
    func testSerialization() {
        let originalEventData = EventData(event: Event(type: .moving, date: Date()))
        let data = NSKeyedArchiver.archivedData(withRootObject: originalEventData)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let eventData = unarchiver.decodeObject(forKey: "root") as? EventData
        XCTAssertEqual(originalEventData.event, eventData?.event)
    }

    func testSerializationArray() {
        let originalEventData = EventData(event: Event(type: .moving, date: Date()))
        let originalEvents = [originalEventData, originalEventData]
        let data = NSKeyedArchiver.archivedData(withRootObject: originalEvents)
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let events = unarchiver.decodeObject(forKey: "root") as? [EventData]
        XCTAssertEqual(originalEvents.first?.event, events?.first?.event)
    }
}
