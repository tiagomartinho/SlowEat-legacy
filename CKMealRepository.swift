import CloudKit

class CKMealRepository: MealRepository {

    let database = CKContainer(identifier: "iCloud.com.elit.SlowEat").privateCloudDatabase

    func hasValidAccount(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
    }

    func save(meal: Meal) {
        let id = CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: "Meal", recordID: id)
        NSKeyedArchiver.setClassName("Event", for: Event.self)
        let data = NSKeyedArchiver.archivedData(withRootObject: meal.events)
        record["events"] = data as CKRecordValue
        database.save(record) { record, error in
            if let error = error {
                print("Save Meal Failed with error: \(error)")
            }
            if let record = record {
                print("Save Meal succeeded with record \(record)")
            }
        }
    }

    func load(completionHandler: @escaping ([Meal]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Meal", predicate: predicate)
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Load Meal Failed with error: \(error)")
            }
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
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Query to Delete Meals Failed with error: \(error)")
            }
            if let records = records {
                for record in records {
                    self.database.delete(withRecordID: record.recordID) { _, error in
                        if let error = error {
                            print("Delete Meals Failed with error: \(error)")
                        }
                    }
                }
            }
        }
    }
}
