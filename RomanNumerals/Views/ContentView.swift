import SwiftUI

struct ContentView: View {
    /// Tracks the text that the user provides
    @State private var textInput = ""

    /// Provides the Roman numerals based on current user input
    @State private var romanNumerals = ""

    /// Tracks current error status
    @State private var error: RomanNumeralsError?

    var body: some View {
        Form {
            Section(header: Text(NSLocalizedString("Generate Roman Numerals",
                                                   comment: "Explain to user what this section does"))) {
                // Responsible for text field that gets user input
                ValueTextView(textInput: $textInput)

                // If an error is present, display its message to the user
                if let error = error {
                    ErrorMessageView(message: error.message)
                }

                // Display the value currently held in romanNumerals
                RomanNumeralsResultView(message: romanNumerals)
            }
        }
        .onChange(of: romanNumerals) { value in
            handleRomanNumeralsChange(value: value)
        }
        .onChange(of: textInput) { value in
            handleTextInputChange(value: value)
        }
    }

    /// Handles resetting error to nil when the romanNumerals value is not empty
    /// - Parameter value: Updated roman numerals value
    private func handleRomanNumeralsChange(value: String) {
        if !value.isEmpty {
            error = nil
        }
    }

    /// Handles changes to the text input from user interaction
    ///
    /// - Note: The outcome will depend on what the user has entered
    /// - Note: 1) A valid Int will be evaluated. Depending on
    /// - Note:    whether or not it is within the acceptable range
    /// - Note:    will determine what is shown to the user.
    /// - Note: 2) An empty value will reset the romanNumerals field.
    /// - Note:    This will typically happen when you delete the last
    /// - Note:    digit in a number.
    /// - Note: 3) A non-Int, non-empty value will be assumed to be
    /// - Note:    invalid user input (such as pasted in) and will
    /// - Note:    produce an invalidInput error.
    ///
    /// - Parameter value: Value to evaluate for converting
    private func handleTextInputChange(value: String) {
        if let number = Int(value.digits) {
            // This is a valid Int, so attempt to convert it
            let result = NumberConverter.romanNumeral(number: number)
            switch result {
            case let .failure(error):
                self.error = error

            case let .success(romanNumerals):
                self.romanNumerals = romanNumerals
            }
        } else if value.isEmpty {
            // This is empty, reset the value back to empty
            romanNumerals = ""
        } else {
            // Not an Int, and not empty, so set error for
            // invalidInput. This is likely a pasted in value
            error = .invalidInput
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
