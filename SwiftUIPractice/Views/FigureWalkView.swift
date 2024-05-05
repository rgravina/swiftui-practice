import SwiftUI

struct FigureWalkView: View {
    let colorGenerator: ColorGenerator
    @State var color: Color

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.color = colorGenerator.color()
    }

    var body: some View {
        Image(systemName: "figure.walk")
            .resizable()
            .scaledToFit()
            .foregroundStyle(color)
            .accessibilityIdentifier("figure.walk")
            .onTapGesture {
                color = colorGenerator.color()
            }
    }
}
