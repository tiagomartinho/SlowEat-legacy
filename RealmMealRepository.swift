import RealmSwift

class RealmMealRepository: MealRepository {

    let realm = try? Realm()

    var uniqueID: String {
        return UUID().uuidString
    }

    func save(meal: Meal) {
        try? realm?.write {
            let realmMeal = RealmMeal()
            realmMeal.set(meal)
            realm?.add(realmMeal)
        }
    }

    func load(completionHandler: @escaping ([Meal]) -> Void) {
        guard let objects = realm?.objects(RealmMeal.self) else {
            completionHandler([])
            return
        }
        let meals = Array(objects).map {
            $0.meal
        }
        completionHandler(meals)
    }

    func delete(with id: String) {
        let predicate = NSPredicate(format: "id = %@", id)
        if let mealToDelete = realm?.objects(RealmMeal.self).filter(predicate).first {
            try? realm?.write {
                realm?.delete(mealToDelete)
            }
        }
    }

    func deleteAll() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }

    func hasValidAccount(completionHandler: @escaping (Bool) -> Void) {
        do {
            _ = try Realm()
            completionHandler(true)
        } catch {
            completionHandler(false)
        }
    }
}

class RealmMeal: Object {

    @objc dynamic var id = ""
    var events = List<RealmEvent>()

    func set(_ meal: Meal) {
        id = meal.id
        let realmEvents = meal.events.map { event -> RealmEvent in
            let realmEvent = RealmEvent()
            realmEvent.type = event.type.rawValue
            realmEvent.date = event.date
            return realmEvent
        }
        let list = List<RealmEvent>()
        list.append(objectsIn: realmEvents)
        events = list
    }

    var meal: Meal {
        let events = Array(self.events.map { Event(type: EventType(rawValue: $0.type) ?? .waiting, date: $0.date) })
        return Meal(id: id, events: events)
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}

class RealmEvent: Object {
    @objc dynamic var type = "waiting"
    @objc dynamic var date = Date()
}
