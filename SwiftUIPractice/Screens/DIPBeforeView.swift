import SwiftUI

// CoffeeMakerApp types
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

enum CoffeeError: Error {
    case noCoffee
}

//protocol CoffeeMaker {
//    func addGroundCoffee(coffee: GroundCoffee)
//    func brew() throws -> Coffee
//}
//
//protocol CoffeeGrinder {
//    func grindBeans() -> GroundCoffee
//}

// Breville types
class BrevilleCoffeeBeansGrinder {
    func grindBeans() -> GroundCoffee {
        return GroundCoffee(grind: .medium, grams: 20)
    }
}

// Bialetti types
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

// Kmart types
//class KMartCoffeeBeansGrinder: CoffeeGrinder {
//    func grindBeans() -> GroundCoffee {
//        return GroundCoffee(grind: .course, grams: 15)
//    }
//}
//
//class KMartStoveTopCoffeeMaker: CoffeeMaker {
//    var groundCoffee: GroundCoffee!
//
//    func addGroundCoffee(coffee: GroundCoffee) {
//        groundCoffee = coffee
//    }
//
//    func brew() throws -> Coffee {
//        guard groundCoffee != nil else {
//            throw CoffeeError.noCoffee
//        }
//        return Coffee(name: "Espresso by KMart")
//    }
//}


class CoffeeMakerApp {
    let grinder: BrevilleCoffeeBeansGrinder
    let maker: BialettiStoveTopCoffeeMaker

    init() {
        grinder = BrevilleCoffeeBeansGrinder()
        maker = BialettiStoveTopCoffeeMaker()
    }

    func brew() throws -> Coffee {
        let groundCoffee = grinder.grindBeans()
        maker.addGroundCoffee(coffee: groundCoffee)
        return try maker.brew()
    }
}

//class CoffeeMakerAppWithDI {
//    let grinder: BrevilleCoffeeBeansGrinder
//    let maker: BialettiStoveTopCoffeeMaker
//
//    init(grinder: BrevilleCoffeeBeansGrinder, maker: BialettiStoveTopCoffeeMaker) {
//        self.grinder = grinder
//        self.maker = maker
//    }
//
//    func brew() throws -> Coffee {
//        let groundCoffee = grinder.grindBeans()
//        maker.addGroundCoffee(coffee: groundCoffee)
//        return try maker.brew()
//    }
//}

//struct CoffeeMakerAppWithDIP {
//    let grinder: CoffeeGrinder
//    let maker: CoffeeMaker
//
//    func brew() throws -> Coffee {
//        let groundCoffee = grinder.grindBeans()
//        maker.addGroundCoffee(coffee: groundCoffee)
//        return try maker.brew()
//    }
//}


class DIPBeforeViewModel: ObservableObject {
    @Published var coffee = [Coffee]()

    func brewCoffee() throws {
        let app = CoffeeMakerApp()
        let cup = try app.brew()
        coffee.append(cup)
    }

    func brewCoffeeWithDIP() throws {
//        let grinder = KMartCoffeeBeansGrinder()
//        let maker = KMartStoveTopCoffeeMaker()
//        let app = CoffeeMakerAppWithDIP(grinder: grinder, maker: maker)
//        let grinder = BrevilleCoffeeBeansGrinder()
//        let maker = BialettiStoveTopCoffeeMaker()
//        let app = CoffeeMakerAppWithDIP(grinder: grinder, maker: maker)
        let app = CoffeeMakerApp()
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
                    try viewModel.brewCoffeeWithDIP()
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
