import SwiftUI

struct DismissKeyboardView: View {
    var body: some View {
        Button {
            dismissKeyboard()
        } label: {
            Image(systemName: "keyboard.chevron.compact.down")
        }
        .accessibility(identifier: "dismissKeyboard")
    }
}

struct DismissKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        DismissKeyboardView()
    }
}
