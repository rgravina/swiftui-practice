import SwiftUI

struct Coffee: Identifiable {
    let id = UUID()
    var name: String
}

class DIPBeforeViewModel: ObservableObject {
    @Published var coffee = Array<Coffee>()

    init() {
        self.coffee = [Coffee(name: "Espresso"), Coffee(name: "Espresso"), Coffee(name: "Espresso"), Coffee(name: "Espresso")]
    }

    func brewCoffee() {
    }
}

struct DIPBeforeView: View {
    let coffeeGridLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var viewModel = DIPBeforeViewModel()

    var body: some View {
        VStack {
            Button("Brew Coffee") {
                viewModel.brewCoffee()
            }.buttonStyle(PrimaryButtonStyle())
            LazyVGrid(columns: coffeeGridLayout) {
                ForEach(viewModel.coffee) { coffee in
                    CoffeeView(coffeeName: coffee.name, imageName: "cup.and.saucer")
                }
            }
            Spacer()
        }
        .padding()
    }
}


struct CoffeeView: View {
    let coffeeName: String
    let imageName: String
    var body: some View {
        VStack {
            Text(coffeeName)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.brown)
        }
    }
}
