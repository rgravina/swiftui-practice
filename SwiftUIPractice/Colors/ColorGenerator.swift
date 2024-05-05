import SwiftUI

protocol ColorGenerator {
    func color() -> Color
}

class RandomPastelColorGenerator: ColorGenerator {
    func color() -> Color {
        return Color.randomPastel()
    }
}
