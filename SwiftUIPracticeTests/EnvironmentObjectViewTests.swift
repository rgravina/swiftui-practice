import XCTest
import SwiftUI
import ViewInspector
import Nimble

@testable import SwiftUIPractice

final class EnvironmentObjectViewTests: XCTestCase {
    var view: EnvironmentObjectView!
    override func setUp() {
        view = EnvironmentObjectView()
        ViewHosting.host(view: view.environmentObject(
            ObservedObjectViewModel(
                colorGenerator: AlwaysOrangeAndPurpleColorGenerator()
            )
        ))
    }

    func testRunIcon_isOrange() throws {
        wait(for: [view.inspection.inspect { [self] view in
            expect(try self.figure(view).foregroundStyleShapeStyle(Color.self)).to(equal(.orange))
        }])
    }

    func testRunIcon_whenTapped_updatesColor() throws {
        wait(for: [view.inspection.inspect { [self] view in
            try figure(view).callOnTapGesture()
            expect(try self.figure(view).foregroundStyleShapeStyle(Color.self)).to(equal(.purple))
        }])
    }

    func testRunIcon_whenTapped_updatesColorDisplay() throws {
        wait(for: [view.inspection.inspect { [self] view in
            try figure(view).callOnTapGesture()
            expect(try self.text(view, "purple")).toNot(throwError())
        }])
    }

    private func text(_ view: InspectableView<ViewType.View<EnvironmentObjectView>>, _ text: String) throws -> InspectableView<ViewType.Text> {
        return try view.find(text: text)
    }

    private func figure(_ view: InspectableView<ViewType.View<EnvironmentObjectView>>) throws -> InspectableView<ViewType.ClassifiedView> {
        return try view
            .find(viewWithAccessibilityIdentifier: "figure.run")
    }
}
