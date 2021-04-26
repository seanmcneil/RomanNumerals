import SwiftUI

struct RomanNumeralsResultView: View {
    /// Message to display
    let message: String

    var body: some View {
        Text(message)
            .accessibility(identifier: "romanNumerals")
            .font(.title)
    }
}

struct RomanNumeralsResultView_Previews: PreviewProvider {
    static var previews: some View {
        RomanNumeralsResultView(message: "XV")
    }
}
