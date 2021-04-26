import XCTest

@testable import RomanNumerals

class StringExtensionTests: XCTestCase {
    // MARK: Digits

    func testDigitsAllNumbers() {
        XCTAssertEqual("123".digits, "123")
    }

    func testDigitsAllNumbersDelimited() {
        XCTAssertEqual("1,234".digits, "1234")
    }

    func testDigitsEmpty() {
        XCTAssertEqual("".digits, "")
    }

    func testDigitsAllLetters() {
        XCTAssertEqual("AbCd".digits, "")
    }

    func testDigitsAlphaNumerics() {
        XCTAssertEqual("Ab12".digits, "12")
    }

    func testDigitsEmoji() {
        XCTAssertEqual("😀 😃 😄 😁 😆 😅 😂 🤣 🥲 ☺️".digits, "")
    }

    // MARK: Format valid input

    func testValidMinimum() {
        var number = "\(RomanNumeralRange.min)"
        number.formatInput()
        XCTAssertEqual(number, "\(RomanNumeralRange.min.delimiter)")
    }

    func testValidMean() {
        let value = (RomanNumeralRange.min + RomanNumeralRange.max) / 2
        var number = "\(value)"
        number.formatInput()
        XCTAssertEqual(number, "\(value.delimiter)")
    }

    func testValidMaximum() {
        var number = "\(RomanNumeralRange.max)"
        number.formatInput()
        XCTAssertEqual(number, "\(RomanNumeralRange.max.delimiter)")
    }

    // MARK: Format invalid input

    func testBelowMinimum() {
        var number = "\(RomanNumeralRange.min - 1)"
        number.formatInput()
        XCTAssertTrue(number.isEmpty)
    }

    func testNegative() {
        var number = "\(-1)"
        number.formatInput()
        print(number)
        XCTAssertTrue(number.isEmpty)
    }

    func testAboveMaximum() {
        var number = "\(RomanNumeralRange.max + 1)"
        number.formatInput()
        XCTAssertEqual(number, "\(400.delimiter)")
    }

    func testAlphaNumeric() {
        var number = "ABC123"
        number.formatInput()
        XCTAssertEqual(number, "\(123.delimiter)")
    }

    func testLetters() {
        var number = "ABC"
        number.formatInput()
        XCTAssertTrue(number.isEmpty)
    }

    func testIntMaximum() {
        var number = "\(Int.max)"
        number.formatInput()
        XCTAssertEqual(number, "\(922.delimiter)")
    }

    func testIntMinimum() {
        var number = "\(Int.min)"
        number.formatInput()
        XCTAssertTrue(number.isEmpty)
    }
}
