import Foundation

extension String {
    /// Provides only the digits contained in the string
    var digits: String {
        // Support for negative numbers requires a - be added to set
        let characterSet = CharacterSet(charactersIn: "-")
            .union(.decimalDigits)

        return components(separatedBy: characterSet.inverted)
            .joined()
    }

    /// Applies formatting of string to enforce allowed values
    mutating func formatInput() {
        // If this is a valid Int, then ensure that it
        // exists within the allowed range values
        if let number = Int(digits),
           number >= RomanNumeralRange.min,
           number <= RomanNumeralRange.max {
            // This is an allowed value, assign a delimited version
            self = number.delimiter
        } else {
            // This string is not a valid Int, so parse the string to extract
            // only valid digits

            // Eliminate all non-digit characters
            var numberCandidate = digits
            while !numberCandidate.isEmpty {
                if let number = Int(numberCandidate),
                   number >= RomanNumeralRange.min,
                   number <= RomanNumeralRange.max {
                    // This is an allowed value, assign a delimited version
                    self = number.delimiter
                    break
                } else {
                    numberCandidate.removeLast()
                }
            }

            if numberCandidate.isEmpty {
                self = ""
            }
        }
    }
}
