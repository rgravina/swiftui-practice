import SwiftUI

struct SimpleStateView: View {
    private let colorGenerator: ColorGenerator
    @State private var color: Color
    internal let inspection = Inspection<Self>()

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.color = colorGenerator.color()
    }

    var body: some View {
        VStack {
            Text("""
This view uses @State to store the color of the icon. Tap the icon to chose a random color.

The button has no @State for color and a random color is chosen each time it is rendered.
""")
            Spacer()
            Button("Button") {
            }.buttonStyle(PrimaryButtonStyle())
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
                .accessibilityIdentifier("figure.walk")
                .onTapGesture {
                    color = colorGenerator.color()
                }
                .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
        }
        .padding()
    }
}

#Preview {
    SimpleStateView(
        colorGenerator: RandomPastelColorGenerator()
    ).preferredColorScheme(.dark)
}
