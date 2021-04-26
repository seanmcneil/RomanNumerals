import XCTest

@testable import RomanNumerals

class IntExtensionTests: XCTestCase {
    func testSingle() {
        XCTAssertEqual(1.delimiter, "1")
    }

    func testTens() {
        XCTAssertEqual(10.delimiter, "10")
    }

    func testHundreds() {
        XCTAssertEqual(100.delimiter, "100")
    }

    func testThousands() {
        // Different regions utilize different delimiters
        // so this tests for the most commonly used versions
        // https://en.wikipedia.org/wiki/Decimal_separator
        let allowable = ["1,000", "1.000", "1 000", "1_000"]
        XCTAssertTrue(allowable.contains(1000.delimiter))
    }
}
