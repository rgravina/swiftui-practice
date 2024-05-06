import SwiftUI

struct UsingStateView: View {
    private static let numIcons = 50
    let colorGenerator: ColorGenerator

    var body: some View {
        VStack {
            Text("""
This view contains a grid of views with their own @State.

The button has no @State for color and a random color is chosen each time it is rendered. But notice how it does not change when icons are tapped.

Tap any icon to chose a random color for that icon.
""")
                .padding()
            Button("Button") {
            }.buttonStyle(PrimaryButtonStyle())
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    ForEach(0..<UsingStateView.numIcons, id: \.self) { index in
                        FigureWalkView(colorGenerator: colorGenerator).id("figure-walk-\(index)")
                    }
                }
                .padding()
            }
        }
    }
}
