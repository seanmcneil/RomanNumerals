import SwiftUI

struct ValueTextView: View {
    /// Tracks the text that the user provides
    @Binding var textInput: String

    /// Indicates whether or not textfield is active
    @State private var isActive = false

    var body: some View {
        HStack {
            NumberInputView(textInput: $textInput,
                            isActive: $isActive)

            if isActive {
                DismissKeyboardView()
            }
        }
    }
}

struct ValueTextView_Previews: PreviewProvider {
    @State private static var textInput = "1234"

    static var previews: some View {
        ValueTextView(textInput: $textInput)
    }
}
