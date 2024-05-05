import SwiftUI
@testable import SwiftUIPractice

class AlwaysOrangeAndPurpleColorGenerator: ColorGenerator {
    var _color: Color = Color.purple

    func color() -> Color {
        _color = _color == .orange ? .purple : .orange
        return _color
    }
}
