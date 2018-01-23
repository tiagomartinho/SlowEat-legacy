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

    func delete(with identifier: String) {
        let predicate = NSPredicate(format: "id = %@", identifier)
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

    @objc dynamic var identifier = ""
    var events = List<RealmEvent>()

    func set(_ meal: Meal) {
        identifier = meal.identifier
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
        return Meal(identifier: identifier, events: events)
    }

    override static func primaryKey() -> String? {
        return "identifier"
    }
}

class RealmEvent: Object {
    @objc dynamic var type = "waiting"
    @objc dynamic var date = Date()
}
