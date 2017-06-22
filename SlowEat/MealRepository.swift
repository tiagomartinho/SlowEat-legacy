protocol MealRepository {
    func save(meal: Meal)
    func load(completionHandler: @escaping ([Meal]) -> (Void))
}
