import SwiftUI

struct BindingView: View {
    private static let numIcons = 15
    private let colorGenerator: ColorGenerator
    @State private var colors: [Color]
    internal let inspection = Inspection<Self>()

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.colors = (0..<BindingView.numIcons).map { _ in colorGenerator.color()}
    }

    private func regenerateColors() {
        self.colors = (0..<BindingView.numIcons).map { _ in colorGenerator.color()}
    }

    var body: some View {
        VStack {
            VStack {
                Text("Subviews use @Binding to a @State array on the parent view. The colors can be changed in the parent via the \"Regenerate Colors\" button or via tapping on any runner icon.")
                Spacer()
                Button("Rengenerate Colors") {
                    regenerateColors()
                }
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 80))
                ]) {
                    ForEach(colors, id: \.cgColor) { color in
                        Text("\(color)")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundColor(color)
                            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
                    }
                }
            }
            VStack {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 60))
                ]) {
                    ForEach(0..<BindingView.numIcons, id: \.self) { index in
                        FigureRunView(colorGenerator: colorGenerator, color: $colors[index])
                            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
                    }
                }
                .accessibilityIdentifier("run-grid")
            }
        }
        .padding()
    }
}
