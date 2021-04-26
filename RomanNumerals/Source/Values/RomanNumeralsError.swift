import Foundation

enum RomanNumeralsError: Error {
    case invalidInput
    case numberTooHigh(Int)
    case numberTooLow(Int)

    /// Message to show to the user
    var message: String {
        switch self {
        case .invalidInput:
            return NSLocalizedString("Only numbers between \(RomanNumeralRange.min.delimiter) and \(RomanNumeralRange.max.delimiter) can be converted.",
                                     comment: "User's input is invalid")

        case let .numberTooHigh(number):
            return NSLocalizedString("\(number.delimiter) is higher than \(RomanNumeralRange.max.delimiter).",
                                     comment: "User's value is out of range")

        case let .numberTooLow(number):
            return NSLocalizedString("\(number.delimiter) is lower than \(RomanNumeralRange.min.delimiter).",
                                     comment: "User's value is out of range")
        }
    }
}

/// This supports unit tests
extension RomanNumeralsError: Equatable {}
