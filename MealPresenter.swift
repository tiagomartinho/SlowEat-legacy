import CloudKit

class MealPresenter {

    let tracker: Tracker
    let logger: Logger

    init(tracker: Tracker, logger: Logger) {
        self.tracker = tracker
        self.logger = logger
    }

    func startMeal() {
        tracker.start()
        logger.start()
    }

    func stopMeal() {
        let container = CKContainer(identifier: "iCloud.com.elit.SlowEat")
        let database = container.privateCloudDatabase
        let id = CKRecordID(recordName: UUID().uuidString)
        let meal = CKRecord(recordType: "Meal", recordID: id)
        meal["title"] = "17" as NSString
        meal["artist"] = "18" as NSString
        meal["address"] = "19" as NSString
        database.save(meal) { record, error in
            print(error)
            print(record)
        }
        tracker.stop()
        logger.stop()
    }

    func waiting() {
        tracker.waiting()
        logger.log(type: .waiting)
    }

    func moving() {
        tracker.moving()
        logger.log(type: .moving)
    }
}
