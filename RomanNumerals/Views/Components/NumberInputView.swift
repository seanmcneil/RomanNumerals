import Combine
import SwiftUI

struct NumberInputView: View {
    /// Tracks the text that the user provides
    @Binding var textInput: String

    /// Indicates whether or not textfield is active
    @Binding var isActive: Bool

    var body: some View {
        TextField(NSLocalizedString("Enter a number from 1 to 3,999",
                                    comment: "Describe input requirements to user"),
                  text: $textInput,
                  onEditingChanged: { editingChanged in
                      isActive = editingChanged
                  })
            .accessibility(identifier: "numberInput")
            .keyboardType(.numberPad)
            .onReceive(Just(textInput)) { _ in
                textInput.formatInput()
            }
    }
}

struct NumberInputView_Previews: PreviewProvider {
    @State private static var textInput = "1234"

    @State private static var isActive = true

    static var previews: some View {
        NumberInputView(textInput: $textInput,
                        isActive: $isActive)
    }
}
