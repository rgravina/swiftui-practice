import XCTest
import Nimble

/*
 * Company 9000 classes (no interfaces used)
 */
class S9000 {
    func isOn() -> Bool {
        return true
    }
}

class B9000 {
    func turnOn() {
    }

    func turnOff() {
    }
}

/*
 * Company 10000 classes (uses SmartHome interfaces)
 */
class S10000: Switch { // compile time dependency to interface
    func isOn() -> Bool {
        return true
    }
}

class B10000: Bulb { // compile time dependency to interface
    func turnOn() {
    }

    func turnOff() {
    }
}

/*
 * Smart Home classes/interfaces
 * - Company 10000 can build against Switch and Bulb
 */
protocol Switch {
    func isOn() -> Bool
}

protocol Bulb {
    func turnOn()
    func turnOff()
}

class SmartHome {
    let toggle: S9000 // compile time dependency to class
    let bulb: B9000 // compile time dependency to class

    init() {
        toggle = S9000() // run time dependency to class
        bulb = B9000() // run time dependency to class
    }

    func run() {
        if toggle.isOn() {
            bulb.turnOn()
        } else {
            bulb.turnOff()
        }
    }
}

class SmartHomeDI {
    let toggle: S9000 // compile time dependency to class
    let bulb: B9000 // compile time dependency to class

    init(toggle: S9000, bulb: B9000) {
        self.toggle = toggle // run time dependency to class
        self.bulb = bulb // run time dependency to class
    }

    func run() {
        if toggle.isOn() {
            bulb.turnOn()
        } else {
            bulb.turnOff()
        }
    }
}

class SmartHomeDIP {
    let toggle: Switch // compile time dependency to interface
    let bulb: Bulb // compile time dependency to interface

    init(toggle: Switch, bulb: Bulb) {
        self.toggle = toggle // rum time dependency to class
        self.bulb = bulb // rum time dependency to class
    }

    func run() {
        if toggle.isOn() {
            bulb.turnOn()
        } else {
            bulb.turnOff()
        }
    }
}

/*
 DIP light/switch example
 */
final class DIPTests: XCTestCase {
    /*
     Simple example using concrete classes and no DI
     */
    func testNoDI() {
        SmartHome().run()
    }

    /*
     Simple example using concrete classes but DI
     */
    func testWithDI() {
        SmartHomeDI(toggle: S9000(), bulb: B9000()).run()
    }

    /*
     Simple example using interfaces and DIP
     */
    func testWithDIP() {
        SmartHomeDIP(toggle: S10000(), bulb: B10000()).run()
    }
}
