import XCTest
import SwiftUI
import ViewInspector
import Nimble

@testable import SwiftUIPractice

final class BindingViewTests: XCTestCase {
    var view: BindingView!

    override func setUp() {
        view = BindingView(colorGenerator: AlwaysOrangeAndPurpleColorGenerator())
        ViewHosting.host(view: view)
    }

    func testRunIcon_isOrange() throws {
        wait(for: [view.inspection.inspect { [self] view in
            expect(try self.figure(view).foregroundStyleShapeStyle(Color.self)).to(equal(.orange))
        }])
    }

    func testRunIcon_whenTapped_updatesColorDisplay() throws {
        wait(for: [view.inspection.inspect { [self] view in
            try figure(view).callOnTapGesture()
            expect(try self.color(view, color: "purple")).toNot(throwError())
        }])
    }

    private func color(_ view: InspectableView<ViewType.View<BindingView>>, color: String) throws -> InspectableView<ViewType.Text> {
        return try view.find(text: color)
    }

    private func figure(_ view: InspectableView<ViewType.View<BindingView>>) throws -> InspectableView<ViewType.ClassifiedView> {
        return try view
            .find(viewWithAccessibilityIdentifier: "figure.run")
    }
}
