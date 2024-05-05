import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            SwiftUIPracticeView(
                colorGenerator: RandomPastelColorGenerator()
            )
        }
    }
}
