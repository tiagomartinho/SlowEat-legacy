import RealmSwift

class RealmMealRepository: MealRepository {

    private var realm = try? Realm()

    var uniqueID: String {
        return UUID().uuidString
    }

    func set(configuration: Realm.Configuration) {
        realm = try? Realm(configuration: configuration)
    }

    func save(meal: Meal) {
        DispatchQueue.main.async {
            try? self.realm?.write {
                let realmMeal = RealmMeal()
                realmMeal.set(meal)
                self.realm?.add(realmMeal)
            }
        }
    }

    func load(completionHandler: @escaping ([Meal]) -> Void) {
        DispatchQueue.main.async {
            guard let objects = self.realm?.objects(RealmMeal.self) else {
                completionHandler([])
                return
            }
            let meals = Array(objects).map {
                $0.meal
            }
            completionHandler(meals)
        }
    }

    func delete(with identifier: String) {
        DispatchQueue.main.async {
            let predicate = NSPredicate(format: "id = %@", identifier)
            if let mealToDelete = self.realm?.objects(RealmMeal.self).filter(predicate).first {
                try? self.realm?.write {
                    self.realm?.delete(mealToDelete)
                }
            }
        }
    }

    func deleteAll() {
        DispatchQueue.main.async {
            try? self.realm?.write {
                self.realm?.deleteAll()
            }
        }
    }

    func hasValidAccount(completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            do {
                _ = try Realm()
                completionHandler(true)
            } catch {
                completionHandler(false)
            }
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
