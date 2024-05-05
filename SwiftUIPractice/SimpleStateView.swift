import SwiftUI

protocol ColorGenerator {
    func color() -> Color
}

class RandomPastelColorGenerator: ColorGenerator {
    func color() -> Color {
        return Color.randomPastel()
    }
}

struct SimpleStateView: View {
    let colorGenerator: ColorGenerator
    @State var color: Color
    internal let inspection = Inspection<Self>()

    init(colorGenerator: ColorGenerator) {
        self.colorGenerator = colorGenerator
        self.color = colorGenerator.color()
    }

    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
                .id("figure.walk")
                .onTapGesture {
                    color = colorGenerator.color()
                }
                .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
        }
        .padding()
    }
}

#Preview {
    SimpleStateView(
        colorGenerator: RandomPastelColorGenerator()
    ).preferredColorScheme(.dark)
}
