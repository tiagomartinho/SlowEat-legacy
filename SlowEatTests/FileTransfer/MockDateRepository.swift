import Foundation
@testable import SlowEat

class MockDateRepository: DateRepository {

    var date: Date!

    func save(date: Date) {
        self.date = date
    }

    func load() -> Date {
        return date
    }
}
