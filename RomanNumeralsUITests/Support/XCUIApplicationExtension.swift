import XCTest

let timeout: TimeInterval = 2.0

let isPad = UIDevice.current.userInterfaceIdiom == .pad

extension XCUIApplication {
    func enterCharacter(character: String) {
        if !keys[String(character)].exists {
            keys["more"].firstMatch.tap()

            if buttons["OK"].exists {
                buttons["OK"].tap()
                keys["more"].firstMatch.tap()
            }
        }

        keys[character].tap()
    }
}
