import Foundation

extension Int {
    /// Provides a locale specific delimiter for string denoting 3 digit blocks
    var delimiter: String {
        (self as NSNumber).description(withLocale: Locale.current)
    }
}
