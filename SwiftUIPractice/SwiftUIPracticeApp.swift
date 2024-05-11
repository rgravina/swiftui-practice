import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    @State var colorGenerator = RandomPastelColorGenerator()
    @StateObject var viewModel = ColorListViewModel(colorGenerator: RandomPastelColorGenerator())

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
                    Label("@State", systemImage: "figure.walk")
                }
                BindingView(
                    colorGenerator: colorGenerator
                ).tabItem {
                    Label("@Binding", systemImage: "figure.run")
                }
                StateObjectView(
                    viewModel: .init(colorGenerator: colorGenerator)
                ).tabItem {
                    Label("@StateObject", systemImage: "figure.run")
                }
                ObservedObjectView(
                    viewModel: .init(colorGenerator: colorGenerator)
                ).tabItem {
                    Label("@ObservedObject", systemImage: "figure.run")
                }
                EnvironmentObjectView().tabItem {
                    Label("@EnvironmentObject 1", systemImage: "figure.run")
                }
                EnvironmentObjectView().tabItem {
                    Label("@EnvironmentObject 2", systemImage: "figure.run")
                }
                CombineView().tabItem {
                    Label("Combine", systemImage: "figure.run")
                }
                DIPBeforeView().tabItem {
                    Label("DIPBeforeView", systemImage: "cup.and.saucer")
                }
                DIPAfterView().tabItem {
                    Label("DIPAfterView", systemImage: "cup.and.saucer.fill")
                }
            }.environmentObject(viewModel)
        }
    }
}
