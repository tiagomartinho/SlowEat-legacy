import CloudKit

class CKMealRepository: MealRepository {
    func save(meal: Meal) {
        let container = CKContainer(identifier: "iCloud.com.elit.SlowEat")
        let database = container.privateCloudDatabase
        let id = CKRecordID(recordName: UUID().uuidString)
        let meal = CKRecord(recordType: "Meal", recordID: id)
        meal["title"] = "17" as NSString
        meal["artist"] = "18" as NSString
        meal["address"] = "19" as NSString
        database.save(meal) { record, error in
        }
    }
}
