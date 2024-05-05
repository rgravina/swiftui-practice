import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SimpleStateView(
                    colorGenerator: RandomPastelColorGenerator()
                ).tabItem {
                    Label("@State", systemImage: "figure.walk")
                }
            }
        }
    }
}
