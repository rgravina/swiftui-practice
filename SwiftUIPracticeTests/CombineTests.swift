import Foundation
import XCTest
import Combine
import Nimble

@testable import SwiftUIPractice

/*
 Many of the examples and learnings here are thanks to:
  - The free Using Combine book by Joseph Heck https://heckj.github.io/swiftui-notes/
  - The Combine Framework Tutorial playlist by Karin Prater https://www.youtube.com/playlist?list=PLWHegwAgjOkoIMgZ7QF_SHUtEB_rWXtH0
 Those are both excellent resources, and I suggest you take a look at them. Thanks to both the developers for making these availble!
 */
final class CombineTests: XCTestCase {
    /*
     Just is a simple publisher that sends its value immediately and then completes.

     1) The pipeline starts with a publisher, and the type is <Int, Never>. Int is what it publishes, and Never is the failure type (it can't fail)
     2) The received value is captured in the sink
     3) Publishers return a Cancellable that can be used to cancel the subscription. We can ignore it here. When the object is deallocated it will automatically cancel.
     4) Like the previous example, but it's type is <String, Never>
     5) A trick question really, it's just <URL, Never>. Nothing special about it.
     */
    func testJustPublisher() {
        _ = Just(5) // 1
            .sink { value in // 2
                print("received: ", value)
            }
        // 3

        _ = Just("hello") // 4
            .sink { value in
                print("received: ", value)
            }

        _ = Just(URL(string: "https://postman-echo.com/get?hello=world")!) // 5
            .sink { value in
                print("received: ", value)
            }
    }

    /*
     The example extends the Just publisher example above, and adds a map operation to the pipeline.

     1) The pipeline starts with a publisher, and the type is <Int, Never>. Int is what it publishes, and Never is the failure type (it can't fail)
     2) The map closure transforms this Int to a String (5 becomes the default 'some')
     3) The sink receives the value and prints it

     Try changing the Just parameter.
     */
    func testJustWithMapPublisher() {
        _ = Just(5) // 1
            .map { value -> String in
                switch value {
                case _ where value < 1:
                    return "無い/none"
                case _ where value == 1:
                    return "一つ/one"
                case _ where value == 2:
                    return "二つ/couple"
                case _ where value == 3:
                    return "少しある/few"
                case _ where value > 8:
                    return "沢山ある/many"
                default:
                    return "結構ある/some"
                }
            }
            .sink { value in // 3
                print("The end result was \(value)")
            }
    }

    /*
        Timer.pubish gives you a publisher that regularly sends values.
     */
    func testTimerPublisher() {
        let expectation = expectation(description: "waiting for timer")

        let cancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { output in
                print("completed with:", output)
            } receiveValue: { value in
                print("got value:", value)
            }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cancellable.cancel()
            expectation.fulfill()
        }

        wait(for: [expectation])
    }

    /*
        scan is an operator that can be used to intercept/scan the stream and transform the value
     */
    func testTimerWithCounterPublisher() {
        let expectation = expectation(description: "waiting for timer")

        let cancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .scan(0, { (count, _) in
                return count + 1
            })
            .sink { output in
                print("completed with:", output)
            } receiveValue: { value in
                print("got value:", value)
            }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cancellable.cancel()
            expectation.fulfill()
        }

        wait(for: [expectation])
    }
}
