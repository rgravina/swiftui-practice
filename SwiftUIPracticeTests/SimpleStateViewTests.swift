import XCTest
import SwiftUI
import ViewInspector
import Nimble

@testable import SwiftUIPractice

class AlwaysOrangeAndPurpleColorGenerator: ColorGenerator {
    var _color: Color = Color.purple

    func color() -> Color {
        _color = _color == .orange ? .purple : .orange
        return _color
    }
}

final class SimpleStateViewTests: XCTestCase {
    var view: SimpleStateView!

    override func setUp() {
        view = SimpleStateView(colorGenerator: AlwaysOrangeAndPurpleColorGenerator())
        ViewHosting.host(view: view)
    }

    func testWalkingIcon_isOrange() throws {
        wait(for: [view.inspection.inspect { [self] view in
            expect(try self.figure(view).foregroundStyleShapeStyle(Color.self)).to(equal(.orange))
        }])
    }

    func testWalkingIcon_whenTapped_isNotOrange() throws {
        wait(for: [view.inspection.inspect { [self] view in
            try figure(view).callOnTapGesture()
            expect(try self.figure(view).foregroundStyleShapeStyle(Color.self)).to(equal(.purple))
        }])
    }

    private func figure(_ view: InspectableView<ViewType.View<SimpleStateView>>) throws -> InspectableView<ViewType.ClassifiedView> {
        return try view.find(viewWithId: "figure.walk")
    }
}
