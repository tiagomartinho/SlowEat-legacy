import XCTest

class TimeFormatterTest: XCTestCase {

    func testFormatTimeInterval() {
        let expected = "01:40"
        let timeInterval = TimeInterval(exactly: 100)!
        let formatter = TimeFormatter()

        let time = formatter.format(timeInterval)

        XCTAssertEqual(expected, time)
    }

    func testFormatTimeIntervalOverflows() {
        let expected = "00:01"
        let timeInterval = TimeInterval(exactly: 3601)!
        let formatter = TimeFormatter()

        let time = formatter.format(timeInterval)

        XCTAssertEqual(expected, time)
    }

    class TimeFormatter {
        func format(_ timeInterval: TimeInterval) -> String {
            let time = Int(timeInterval)
            let minutes = time / 60 % 60
            let seconds = time % 60
            return String(format:"%02i:%02i", minutes, seconds)
        }
    }
}
