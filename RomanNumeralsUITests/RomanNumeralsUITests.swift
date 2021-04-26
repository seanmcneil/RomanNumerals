import XCTest

class RomanNumeralsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait

        app = XCUIApplication()
        app.launch()
    }

    /// Enter a single valid number and dismiss keyboard
    func testValidInput() {
        let textField = app.textFields.element(matching: .textField,
                                               identifier: "numberInput")
        XCTAssertTrue(textField.waitForExistence(timeout: timeout))
        XCTAssertEqual(textField.value as! NSString,
                       "Enter a number from 1 to 3,999")
        textField.tap()

        // Enter 1,234
        app.enterCharacter(character: "1")
        let romanNumerals = app.staticTexts.element(matching: .staticText,
                                                    identifier: "romanNumerals")
        XCTAssertTrue(romanNumerals.waitForExistence(timeout: timeout))

        XCTAssertEqual(romanNumerals.label, "I")
        // Enter 2
        app.enterCharacter(character: "2")
        XCTAssertEqual(romanNumerals.label, "XII")
        // Enter 3
        app.enterCharacter(character: "3")
        XCTAssertEqual(romanNumerals.label, "CXXIII")
        // Enter 4
        app.enterCharacter(character: "4")
        XCTAssertEqual(romanNumerals.label, "MCCXXXIV")

        // Dismiss keyboard
        let dismissButton = app.buttons.element(matching: .button,
                                                identifier: "dismissKeyboard")
        XCTAssertTrue(dismissButton.waitForExistence(timeout: timeout))
        dismissButton.tap()
        // Verify button is removed since textfield is not active
        XCTAssertFalse(dismissButton.exists)
    }

    /// Enter extreme values and confirm error messages appear
    func testInvalidRanged() {
        let textField = app.textFields.element(matching: .textField,
                                               identifier: "numberInput")
        XCTAssertTrue(textField.waitForExistence(timeout: timeout))
        textField.tap()

        // Enter 0
        app.enterCharacter(character: "0")
        let romanNumerals = app.staticTexts.element(matching: .staticText,
                                                    identifier: "romanNumerals")
        XCTAssertTrue(romanNumerals.waitForExistence(timeout: timeout))
        // Verify presence of error message
        let errorMessage = app.staticTexts.element(matching: .staticText,
                                                   identifier: "errorMessage")
        XCTAssertTrue(errorMessage.waitForExistence(timeout: timeout))
        XCTAssertEqual(errorMessage.label, "0 is lower than 1.")

        XCTAssertTrue(romanNumerals.label.isEmpty)

        // Enter 4,000
        app.enterCharacter(character: "4")
        // Error message should now be gone
        XCTAssertFalse(errorMessage.exists)
        XCTAssertEqual(romanNumerals.label, "IV")
        // Enter 0
        app.enterCharacter(character: "0")
        XCTAssertEqual(romanNumerals.label, "XL")
        // Enter 0
        app.enterCharacter(character: "0")
        XCTAssertEqual(romanNumerals.label, "CD")
        // Enter 0 (error should now appear)
        app.enterCharacter(character: "0")
        XCTAssertEqual(errorMessage.label, "4,000 is higher than 3,999.")
        XCTAssertEqual(romanNumerals.label, "CD")
        // Delete 3 chars
        textField.deleteLastCharacters(count: 3)
        XCTAssertEqual(romanNumerals.label, "")
    }

    /// Enter text values from clipboard and confirm error message appears
    func testPasteInvalidChars() {
        UIPasteboard.general.string = "text"

        let textField = app.textFields.element(matching: .textField,
                                               identifier: "numberInput")
        XCTAssertTrue(textField.waitForExistence(timeout: timeout))
        textField.tap()

        app.typeText(UIPasteboard.general.string ?? "text")
        // Verify presence of error message
        let errorMessage = app.staticTexts.element(matching: .staticText,
                                                   identifier: "errorMessage")
        XCTAssertTrue(errorMessage.waitForExistence(timeout: timeout))
        XCTAssertEqual(errorMessage.label,
                       "Only numbers between 1 and 3,999 can be converted.")
    }

    func testExitAndRotate() {
        let textField = app.textFields.element(matching: .textField,
                                               identifier: "numberInput")
        XCTAssertTrue(textField.waitForExistence(timeout: timeout))
        textField.tap()

        // Enter 2,021
        app.enterCharacter(character: "2")
        let romanNumerals = app.staticTexts.element(matching: .staticText,
                                                    identifier: "romanNumerals")
        XCTAssertTrue(romanNumerals.waitForExistence(timeout: timeout))

        XCTAssertEqual(romanNumerals.label, "II")
        // Enter 0
        app.enterCharacter(character: "0")
        XCTAssertEqual(romanNumerals.label, "XX")
        // Enter 2
        app.enterCharacter(character: "2")
        XCTAssertEqual(romanNumerals.label, "CCII")
        // Enter 1
        app.enterCharacter(character: "1")
        XCTAssertEqual(romanNumerals.label, "MMXXI")
        // Background the app
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        // Rotate to landscape left
        XCUIDevice.shared.orientation = .landscapeLeft
        // Return to app
        app.activate()
        XCTAssertEqual(romanNumerals.label, "MMXXI")
        // Delete last character
        textField.deleteLastCharacters(count: 1)
        XCTAssertEqual(romanNumerals.label, "CCII")
    }
}
