import SwiftUI

struct BindingView: View {
    private static let numIcons = 20
    private let colorGenerator: ColorGenerator
    @State private var colors: [Color]
    internal let inspection = Inspection<Self>()

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.colors = (0..<BindingView.numIcons).map { _ in colorGenerator.color()}
    }

    var body: some View {
        VStack {
            VStack {
                Text("This view contains a grid of views that have a @Binding to @State on the parent view. This is why we can print the list of colors below. Tap any icon to chose a random pastel color.")
                    .padding()
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 10) {
                    ForEach(colors, id: \.cgColor) { color in
                        Text("\(color)")
                            .font(.caption)
                            .foregroundColor(color)
                            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
                    }
                }
            }
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    ForEach(0..<BindingView.numIcons, id: \.self) { index in
                        FigureRunView(colorGenerator: colorGenerator, color: $colors[index])
                            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
                    }
                }
                .accessibilityIdentifier("run-grid")
            }
        }
    }
}
