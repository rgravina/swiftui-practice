import SwiftUI

struct UsingStateView: View {
    static let numIcons = 50
    let colorGenerator: ColorGenerator

    var body: some View {
        VStack {
            Text("This view contains a grid of views with their own @State. Tap any icon to chose a random pastel color.")
                .padding()
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    ForEach(0..<UsingStateView.numIcons, id: \.self) { _ in
                        FigureWalkView(colorGenerator: colorGenerator)
                    }
                }
            }
        }
    }
}
