import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    var color: Color = Color.randomPastel()

    func body(content: Content) -> some View {
        content
            .frame(height: 40)
            .padding(.horizontal, 4)
            .background(color)
            .foregroundStyle(.black)
    }
}
