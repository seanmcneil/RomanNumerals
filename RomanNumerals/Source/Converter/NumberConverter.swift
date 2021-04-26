import Foundation

enum RomanNumeralRange {
    static let min = 1
    static let max = 3999
}

private typealias Pair = (decimal: Int, numeral: String)

// Tracks the pairs of decimal values with their corresponding roman numeral
// To handle proceeding values (such as IX), these pairings are also captured.
// If additional values were to be added (such as MS/4,000 and S/5,000) then
// these can just be added to the array in the correct location.
private let values = [Pair(1000, "M"),
                      Pair(900, "CM"),
                      Pair(500, "D"),
                      Pair(400, "CD"),
                      Pair(100, "C"),
                      Pair(90, "XC"),
                      Pair(50, "L"),
                      Pair(40, "XL"),
                      Pair(10, "X"),
                      Pair(9, "IX"),
                      Pair(5, "V"),
                      Pair(4, "IV"),
                      Pair(1, "I")]

// This makes use of an enum since there is currently no scenario
// where a class or struct would have to be initialized. While a
// free function would reduce visual clutter, using an enum to
// scope it will scale well if additional functionality is added
// at a later date.
enum NumberConverter {
    /// Attempts to convert a given Int into a Roman numeral
    ///
    /// The following illustrates how this will work
    /// when given a value of 6.
    /// All pair decimal values will exceed 6, until 5
    /// comes up. Since V is 5's pair, then V will be
    /// added to the `result` and the loop will continue
    /// after subtracting 5 from 6.
    /// Since that leaves a value of 1, then the next run
    /// will see that a `currentValue` of 1 - a `pair.decimal`
    /// of 1, so 1's pair of I will be added to the `result`.
    /// Since no further values can be found, it will return
    /// "VI" as the answer.
    ///
    /// - Parameter number: Int to convert
    /// - Returns: Result containing the Roman numeral, or an error
    static func romanNumeral(number: Int) -> Result<String, RomanNumeralsError> {
        guard number >= RomanNumeralRange.min else {
            return .failure(.numberTooLow(number))
        }

        guard number <= RomanNumeralRange.max else {
            return .failure(.numberTooHigh(number))
        }

        // Stores result to return once number is processed
        var result = ""
        // Create a mutable number to decrement
        var currentValue = number

        // Continue to loop while there are values to process
        while currentValue > 0 {
            // Loop through the pairs
            for pair in values {
                // If the currentValue is higher than the
                // current pair.decimal value, proceed
                if currentValue - pair.decimal >= 0 {
                    // Decrement currentValue by pair.decimal
                    // since that value will be added to result
                    currentValue -= pair.decimal
                    // append the pair.numeral value
                    result += pair.numeral
                    // This pair has been processed, move on
                    break
                }
            }
        }

        return .success(result)
    }
}
