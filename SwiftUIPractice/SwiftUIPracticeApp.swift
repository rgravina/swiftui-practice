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
                    Label("Using @State", systemImage: "figure.walk")
                }
                BindingView(
                    colorGenerator: colorGenerator
                ).tabItem {
                    Label("Using @Binding", systemImage: "figure.run")
                }
                StateObjectView(
                    viewModel: .init(colorGenerator: colorGenerator)
                ).tabItem {
                    Label("Using @StateObject", systemImage: "figure.run")
                }
            }
        }
    }
}
