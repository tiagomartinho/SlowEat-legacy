import Foundation

protocol TimeTracker {
    var startDate: Date? { get }
    var endDate: Date? { get }
    var currentTime: TimeInterval? { get }
    func start()
    func stop()
}
