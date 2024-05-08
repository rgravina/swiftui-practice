import SwiftUI

class ColorListViewModel: ObservableObject {
    let colorGenerator: ColorGenerator
    static let numIcons = 15
    @Published var colors: [Color]

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.colors = (0..<ColorListViewModel.numIcons).map { _ in colorGenerator.color()}
    }

    func regenerateColors() {
        self.colors = (0..<ColorListViewModel.numIcons).map { _ in colorGenerator.color()}
    }
}
