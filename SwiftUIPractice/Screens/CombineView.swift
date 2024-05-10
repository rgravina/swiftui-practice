import SwiftUI

struct CombineView: View {
    @ObservedObject var viewModel: ColorListViewModel

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    Text("""
TODO: This view uses Combine.
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
                    }
                }
            }
            VStack {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 60))
                ]) {
                    ForEach(0..<ColorListViewModel.numIcons, id: \.self) { index in
                        FigureRunView(colorGenerator: viewModel.colorGenerator, color: $viewModel.colors[index])
                    }
                }
            }
        }
        .padding()
    }
}
