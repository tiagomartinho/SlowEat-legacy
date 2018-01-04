class MealAnalyser {
    func analyse(meal: Meal) -> Meal {
        return FilterMoving().filter(meal: meal)
    }
}
