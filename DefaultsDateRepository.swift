import Foundation

class DefaultsDateRepository: DateRepository {

    private let defaults = UserDefaults.standard
    private let dateKey = "Date"

    func save(date: Date) {
        defaults.set(date, forKey: dateKey)
    }

    func load() -> Date {
        if let date = defaults.value(forKey: dateKey) as? Date {
            return date
        } else {
            return Date(timeIntervalSince1970: 0)
        }
    }
}
