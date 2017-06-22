import Foundation

class TimeFormatter {
    static func format(_ timeInterval: TimeInterval) -> String {
        let time = Int(timeInterval)
        let minutes = time / 60 % 60
        let seconds = time % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
