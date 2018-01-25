import Foundation

protocol DateRepository {
    func save(date: Date)
    func load() -> Date
}
