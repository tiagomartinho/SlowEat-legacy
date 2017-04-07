import XCTest
@testable import SlowEat

class TimeFormatterTest: XCTestCase {

    func testFormatTimeInterval() {
        let expected = "01:40"
        let timeInterval = TimeInterval(exactly: 100)!

        let time = TimeFormatter.format(timeInterval)

        XCTAssertEqual(expected, time)
    }

    func testFormatTimeIntervalOverflows() {
        let expected = "00:01"
        let timeInterval = TimeInterval(exactly: 3601)!

        let time = TimeFormatter.format(timeInterval)

        XCTAssertEqual(expected, time)
    }
}
