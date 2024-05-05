import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    @State var colorGenerator = RandomPastelColorGenerator()

    var body: some Scene {
        WindowGroup {
            TabView {
                SimpleStateView(
                    colorGenerator: colorGenerator
                ).tabItem {
                    Label("@State", systemImage: "figure.walk")
                }
                UsingStateView(
                    colorGenerator: colorGenerator
                ).tabItem {
                    Label("Using @State", systemImage: "figure.run")
                }
            }
        }
    }
}
