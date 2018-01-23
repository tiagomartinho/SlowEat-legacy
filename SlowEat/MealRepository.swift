protocol MealRepository {
    var uniqueID: String { get }
    func save(meal: Meal)
    func load(completionHandler: @escaping ([Meal]) -> Void)
    func delete(with identifier: String)
    func deleteAll()
    func hasValidAccount(completionHandler: @escaping (Bool) -> Void)
}
