import SwiftUI

class StateObjectViewModel: ObservableObject {
    let colorGenerator: ColorGenerator
    static let numIcons = 15
    @Published var colors: [Color]

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.colors = (0..<StateObjectViewModel.numIcons).map { _ in colorGenerator.color()}
    }

    func regenerateColors() {
        self.colors = (0..<StateObjectViewModel.numIcons).map { _ in colorGenerator.color()}
    }
}

struct StateObjectView: View {
    @StateObject var viewModel: StateObjectViewModel
    internal let inspection = Inspection<Self>()

    var body: some View {
        VStack {
            VStack {
                Text("Subviews use @Binding to an @ObservableObject view model, which is a @StateObject on the view. The colors can be changed in the parent via the \"Regenerate Colors\" button or via tapping on any runner icon.")
                Spacer()
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
                .accessibilityIdentifier("run-grid")
            }
        }
        .padding()
    }
}
