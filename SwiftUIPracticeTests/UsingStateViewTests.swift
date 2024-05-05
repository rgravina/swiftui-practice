import XCTest
import SwiftUI
import ViewInspector
import Nimble

@testable import SwiftUIPractice

final class UsingStateViewTests: XCTestCase {
    var view: UsingStateView!

    override func setUp() {
        view = UsingStateView(colorGenerator: AlwaysOrangeAndPurpleColorGenerator())
        ViewHosting.host(view: view)
    }

    func testWalkingIcon_isOrange() throws {
        expect(try self.figure(self.view).foregroundStyleShapeStyle(Color.self)).to(equal(.orange))
    }

    func testWalkingIcon_whenTapped_isNotOrange() throws {
        try self.figure(self.view).callOnTapGesture()
        expect(try self.figure(self.view).foregroundStyleShapeStyle(Color.self)).to(equal(.purple))
    }

    private func figure(_ view: UsingStateView) throws -> InspectableView<ViewType.ClassifiedView> {
        return try view.inspect().find(viewWithAccessibilityIdentifier: "figure.walk")
    }
}
