import SwiftUI

class ObservedObjectViewModel: ObservableObject {
    let colorGenerator: ColorGenerator
    static let numIcons = 15
    @Published var colors: [Color]

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.colors = (0..<ObservedObjectViewModel.numIcons).map { _ in colorGenerator.color()}
    }

    func regenerateColors() {
        self.colors = (0..<ObservedObjectViewModel.numIcons).map { _ in colorGenerator.color()}
    }
}

struct ObservedObjectView: View {
    @ObservedObject var viewModel: ObservedObjectViewModel
    internal let inspection = Inspection<Self>()

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    Text("""
Subviews use @Binding to an @ObservableObject view model, which is a @ObservedObject on the view.

The button has no @State for color and a random color is chosen each time it is rendered.

The colors can be changed in the parent via the \"Regenerate Colors\" button or via tapping on any runner icon.
""")
                }
                Button("Rengenerate Colors") {
                    viewModel.regenerateColors()
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 80))
                ]) {
                    ForEach(viewModel.colors, id: \.cgColor) { color in
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
                    ForEach(0..<StateObjectViewModel.numIcons, id: \.self) { index in
                        FigureRunView(colorGenerator: viewModel.colorGenerator, color: $viewModel.colors[index])
                            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
                    }
                }
            }
        }
        .padding()
    }
}
