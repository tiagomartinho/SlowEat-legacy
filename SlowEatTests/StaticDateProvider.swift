@testable import SlowEat

class StaticDateProvider: DateProvider {
    var currentDate = Date(timeIntervalSince1970: 0)
}
