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
        completionHandler(realm?.objects(RealmMeal.self).map {
            $0.meal
        } ?? [])
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

    class RealmMeal: Object {

        @objc dynamic var id = ""
        @objc dynamic var events: [Event] = []

        func set(_ meal: Meal) {
            id = meal.id
            events = meal.events
        }

        var meal: Meal {
            return Meal(id: id, events: events)
        }

        override static func primaryKey() -> String? {
            return "id"
        }
    }
}
