import SwiftUI

extension Color {
    static func randomPastel() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)

        return Color(
            red: (red + 1) / 2,
            green: (green + 1) / 2,
            blue: (blue + 1) / 2
        )
    }
}
