import SwiftUI

struct Coffee: Identifiable {
    let id = UUID()
    var name: String
}

enum Grind {
    case fine, medium, course
}

struct GroundCoffee {
    let grind: Grind
    let grams: Int
}

class BrevilleCoffeeBeansGrinder {
    func grindBeans() -> GroundCoffee {
        return GroundCoffee(grind: .medium, grams: 20)
    }
}

enum CoffeeError: Error {
    case noCoffee
}

class BialettiStoveTopCoffeeMaker {
    var groundCoffee: GroundCoffee!

    func addGroundCoffee(coffee: GroundCoffee) {
        groundCoffee = coffee
    }

    func brew() throws -> Coffee {
        guard groundCoffee != nil else {
            throw CoffeeError.noCoffee
        }
        return Coffee(name: "Espresso by Bialetti")
    }
}

struct CoffeeMakerApp {
    let grinder: BrevilleCoffeeBeansGrinder
    let maker: BialettiStoveTopCoffeeMaker

    func brew() throws -> Coffee {
        let groundCoffee = grinder.grindBeans()
        maker.addGroundCoffee(coffee: groundCoffee)
        return try maker.brew()
    }
}

class DIPBeforeViewModel: ObservableObject {
    @Published var coffee = Array<Coffee>()

    func brewCoffee() throws {
        let grinder = BrevilleCoffeeBeansGrinder()
        let maker = BialettiStoveTopCoffeeMaker()
        let app = CoffeeMakerApp(grinder: grinder, maker: maker)
        let cup = try app.brew()
        coffee.append(cup)
    }
}

struct DIPBeforeView: View {
    let coffeeGridLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var viewModel = DIPBeforeViewModel()

    var body: some View {
        VStack {
            Button("Brew Coffee") {
                do {
                    try viewModel.brewCoffee()
                } catch CoffeeError.noCoffee {
                    print("No coffee in machine!")
                } catch {
                    print("other error")
                }
            }.buttonStyle(PrimaryButtonStyle())
            LazyVGrid(columns: coffeeGridLayout) {
                ForEach(viewModel.coffee) { coffee in
                    CoffeeView(coffeeName: coffee.name)
                }
            }
            Spacer()
        }
        .padding()
    }
}


struct CoffeeView: View {
    let coffeeName: String
    let imageName: String = "cup.and.saucer"
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
