@testable import SlowEat

class SpyMealView: MealView {

    var showNoAccountErrorCalled = false

    func showNoAccountError() {
        showNoAccountErrorCalled = true
    }
}
