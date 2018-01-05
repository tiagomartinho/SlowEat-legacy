class MealAnalyser {
    func analyse(meal: Meal) -> GradedMeal {
        let filteredMeal = FilterMoving().filter(meal: meal)
        let gradedMeal = MealGrader().grade(meal: filteredMeal)
        return gradedMeal
    }
}
