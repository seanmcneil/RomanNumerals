import XCTest

extension XCUIElement {
    /// Will perform a deletion against a textfield
    /// - Parameter count: How many characters to delete (starting from end)
    func deleteLastCharacters(count: Int) {
        guard let stringValue = (value as? String)?.digits,
              stringValue.count >= count
        else {
            return
        }

        let maxLength = stringValue.count - count
        var deleteString = String(stringValue.prefix(maxLength))
        for _ in 0 ..< count {
            deleteString.append(XCUIKeyboardKey.delete.rawValue)
        }
        typeText(deleteString)
    }
}

private extension String {
    /// Provides only the digits contained in the string
    var digits: String {
        let characterSet = CharacterSet(charactersIn: "-")
            .union(.decimalDigits)

        return components(separatedBy: characterSet.inverted)
            .joined()
    }
}
