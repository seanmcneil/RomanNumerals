import XCTest

@testable import RomanNumerals

class NumberConverterTests: XCTestCase {
    // MARK: Success - small numbers

    func testMin() {
        let result = NumberConverter.romanNumeral(number: RomanNumeralRange.min)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "I")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test23() {
        let result = NumberConverter.romanNumeral(number: 23)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "XXIII")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test39() {
        let result = NumberConverter.romanNumeral(number: 39)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "XXXIX")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test246() {
        let result = NumberConverter.romanNumeral(number: 246)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "CCXLVI")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test789() {
        let result = NumberConverter.romanNumeral(number: 789)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "DCCLXXXIX")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test2421() {
        let result = NumberConverter.romanNumeral(number: 2421)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MMCDXXI")

        default:
            XCTFail("Unexpected result")
        }
    }

    // MARK: Success - zeroes

    func test160() {
        let result = NumberConverter.romanNumeral(number: 160)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "CLX")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test207() {
        let result = NumberConverter.romanNumeral(number: 207)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "CCVII")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test1009() {
        let result = NumberConverter.romanNumeral(number: 1009)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MIX")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test1066() {
        let result = NumberConverter.romanNumeral(number: 1066)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MLXVI")

        default:
            XCTFail("Unexpected result")
        }
    }

    // MARK: Success - large numbers

    func test1776() {
        let result = NumberConverter.romanNumeral(number: 1776)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MDCCLXXVI")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test1918() {
        let result = NumberConverter.romanNumeral(number: 1918)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MCMXVIII")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test1954() {
        let result = NumberConverter.romanNumeral(number: 1954)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MCMLIV")

        default:
            XCTFail("Unexpected result")
        }
    }

    func test2021() {
        let result = NumberConverter.romanNumeral(number: 2021)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MMXXI")

        default:
            XCTFail("Unexpected result")
        }
    }

    func testMax() {
        let result = NumberConverter.romanNumeral(number: RomanNumeralRange.max)
        switch result {
        case let .success(value):
            XCTAssertEqual(value, "MMMCMXCIX")

        default:
            XCTFail("Unexpected result")
        }
    }

    // MARK: Failure cases

    func testBelowMin() {
        let number = RomanNumeralRange.min - 1
        let result = NumberConverter.romanNumeral(number: number)
        switch result {
        case let .failure(error):
            XCTAssertEqual(error, .numberTooLow(number))

        default:
            XCTFail("Unexpected result")
        }
    }

    func testAboveMax() {
        let number = RomanNumeralRange.max + 1
        let result = NumberConverter.romanNumeral(number: number)
        switch result {
        case let .failure(error):
            XCTAssertEqual(error, .numberTooHigh(number))

        default:
            XCTFail("Unexpected result")
        }
    }
}
