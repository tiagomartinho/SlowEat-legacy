protocol MealRepository {
    func save(meal: Meal)
    func load(completionHandler: @escaping ([Meal]) -> Void)
    func hasValidAccount(completionHandler: @escaping (Bool) -> Void)
}
