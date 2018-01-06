@testable import SlowEat
import XCTest

class TimeFormatterTest: XCTestCase {

    func testFormatTimeInterval() {
        let expected = "01:40"

        let time = TimeFormatter.format(TimeInterval(exactly: 100)!)

        XCTAssertEqual(expected, time)
    }

    func testFormatTimeIntervalOverflows() {
        let expected = "00:01"

        let time = TimeFormatter.format(TimeInterval(exactly: 3601)!)

        XCTAssertEqual(expected, time)
    }
}
