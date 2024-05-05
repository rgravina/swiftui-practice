import SwiftUI

struct FigureRunView: View {
    let colorGenerator: ColorGenerator
    @Binding var color: Color

    var body: some View {
        Image(systemName: "figure.run")
            .resizable()
            .scaledToFit()
            .foregroundStyle(color)
            .accessibilityIdentifier("figure.run")
            .onTapGesture {
                color = colorGenerator.color()
            }
    }
}
