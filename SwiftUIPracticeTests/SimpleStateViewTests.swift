import XCTest
import SwiftUI
import ViewInspector
import Nimble

@testable import SwiftUIPractice

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

    func testWalkingIcon_withoutViewInspectorInspection_whenTapped_isNotOrange() throws {
        try XCTExpectFailure("inspection must be used") {
            try self.figure1(self.view).callOnTapGesture()
            expect(try self.figure1(self.view).foregroundStyleShapeStyle(Color.self)).to(equal(.purple))
        }
    }

    private func figure1(_ view: SimpleStateView) throws -> InspectableView<ViewType.ClassifiedView> {
        return try view.inspect().find(viewWithAccessibilityIdentifier: "figure.walk")
    }

    private func figure(_ view: InspectableView<ViewType.View<SimpleStateView>>) throws -> InspectableView<ViewType.ClassifiedView> {
        return try view.find(viewWithAccessibilityIdentifier: "figure.walk")
    }
}
