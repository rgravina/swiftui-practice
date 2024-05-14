import XCTest
import Nimble

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

protocol Switch {
    func isOn() -> Bool
}

protocol Bulb {
    func turnOn()
    func turnOff()
}

class S10000: Switch {
    func isOn() -> Bool {
        return true
    }
}

class B10000: Bulb {
    func turnOn() {
    }

    func turnOff() {
    }
}

class SmartHome {
    let toggle: S9000
    let bulb: B9000

    init() {
        toggle = S9000()
        bulb = B9000()
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
    let toggle: S9000
    let bulb: B9000

    init(toggle: S9000, bulb: B9000) {
        self.toggle = toggle
        self.bulb = bulb
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
    let toggle: Switch
    let bulb: Bulb

    init(toggle: Switch, bulb: Bulb) {
        self.toggle = toggle
        self.bulb = bulb
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
