import SwiftUI

struct ErrorMessageView: View {
    /// Message to display
    let message: String

    var body: some View {
        Text(message)
            .accessibility(identifier: "errorMessage")
            .foregroundColor(.red)
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(message: "This is an error message")
    }
}
