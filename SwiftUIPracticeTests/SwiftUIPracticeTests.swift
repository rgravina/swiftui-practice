import XCTest
import ViewInspector
import Nimble

@testable import SwiftUIPractice

final class SwiftUIPracticeTests: XCTestCase {
    func testWalkingIcon() throws {
        let view = SwiftUIPracticeView()

        expect(try view.inspect().find(viewWithId: "figure.walk")).toNot(throwError())
    }
}
