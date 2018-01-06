import CloudKit

class CKMealRepository: MealRepository {

    let database = CKContainer(identifier: "iCloud.com.elit.SlowEat").privateCloudDatabase

    func save(meal: Meal) {
        let id = CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: "Meal", recordID: id)
        NSKeyedArchiver.setClassName("Event", for: Event.self)
        let data = NSKeyedArchiver.archivedData(withRootObject: meal.events)
        record["events"] = data as CKRecordValue
        database.save(record) { _, _ in }
    }

    func load(completionHandler: @escaping ([Meal]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Meal", predicate: predicate)
        database.perform(query, inZoneWith: nil) { records, _ in
            var meals = [Meal]()
            if let records = records {
                for record in records {
                    if let events = record["events"],
                        let data = events as? Data {
                        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                        unarchiver.setClass(Event.self, forClassName: "Event")
                        if let events = try? unarchiver.decodeTopLevelObject(forKey: "root") as? [Event] {
                            if let events = events {
                                meals.append(Meal(events: events))
                            }
                        }
                    }
                }
            }
            completionHandler(meals)
        }
    }

    func deleteAll() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Meal", predicate: predicate)
        database.perform(query, inZoneWith: nil) { records, _ in
            if let records = records {
                for record in records {
                    self.database.delete(withRecordID: record.recordID) { _, _ in }
                }
            }
        }
    }
}
