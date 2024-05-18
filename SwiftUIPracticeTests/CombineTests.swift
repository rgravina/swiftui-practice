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

    /*
     A sequence publisher

     1) sequence publishers complete when the sequence is empty
     */
    func testSequencePublisher() {
        let fridge: Publishers.Sequence<[String], Never> = ["chocolate", "ham", "milk", "salami", "mortadella"].publisher

        _ = fridge.sink(receiveCompletion: { completion in
            print("completion: ", completion) // 1
        }, receiveValue: { food in
            print("food: ", food)
        })
    }

    /*
     Subscribers can be limited also.

     1) The two streams are zipped, so the sequence running out prevents the timer from continuously publishing
     */
    func testLimitedSubscriber() {
        let expectation = expectation(description: "waiting for timer")
        let fridge = ["chocolate", "ham", "milk", "salami", "mortadella"].publisher
        let timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()

        let cancellable = fridge.zip(timer).sink(receiveCompletion: { completion in
            print("completion: ", completion)
        }, receiveValue: { (food, timestamp) in
            print("food: \(food) at: \(timestamp).") // 1
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            cancellable.cancel()
            expectation.fulfill()
        }

        wait(for: [expectation])
    }

    /*
     Subscribers can be limited also.

     1) The two streams are zipped, so the sequence running out prevents the timer from continuously publishing
     2) This forces an error to occur after a few seconds
     3) We can see the completion completed with an error

     Error handling is important when dealting with publishers like those returned by URLSession.
     */
    func testLimitedSubscriberWithError() {
        let expectation = expectation(description: "waiting for timer")
        let fridge = ["chocolate", "ham", "milk", "salami", "mortadella"].publisher
        let timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
        let endDate = Calendar.current.date(byAdding: .second, value: 3, to: Date())!

        struct FoodError: Error {}

        func throwAtEndDate(food: String, timestamp: Date) throws -> String {
            if timestamp < endDate {
                return  "\(food) at: \(timestamp)"
            } else {
                throw FoodError()
            }
        }

        let cancellable = fridge.zip(timer)
            .tryMap({ (food, timestamp) in
                try throwAtEndDate(food: food, timestamp: timestamp) // 2
            })
            .sink(receiveCompletion: { completion in
                print("completion: ", completion)
                switch completion {
                case .finished:
                    print("everything is OK")
                case .failure(let error):
                    print("something went wrong: \(error.localizedDescription)")
                }
            }, receiveValue: { (message) in
                print("food: \(message).") // 1
            })

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            cancellable.cancel()
            expectation.fulfill()
        }

        wait(for: [expectation])
    }

    class IntWrapper {
        var int = 0 {
            didSet {
                print("int was set to \(int)")
            }
        }
    }

    /*
     Assign can be used to set a property on an object.

     1) Ranges (like arrays) can produce publishers
     2) As an alternative to sink, you can use assign to set a property.
     */
    func testAssign() {
        let object = IntWrapper()
        let range = (0...2)
        _ = range.publisher // 1
            .map { $0 * 10 }
            .sink { value in
                object.int = value
            }

        _ = range.publisher
            .map { $0 * 10 }
            .assign(to: \.int, on: object) // 2
    }

    /*
     Now it's time to talk more about Publishers. The CurrentValueSubject you can think of as a `var` with a publisher stream attached.

     1) You can get the value of a subject immediately
     2) You can send values and complete the stream at any time
     3) Values are ignored if the stream is completed.
     */
    func testCurrentValueSubject() {
        let currentBalance = CurrentValueSubject<Int, Never>(25)

        print("currentBalance: \(currentBalance.value)") // 1

        _ = currentBalance.sink(receiveCompletion: { completion in
            print("completion: \(completion)")
        }, receiveValue: {value in
            print("value: \(value)")
        })

        currentBalance.send(30) // 2
        currentBalance.send(35)
        currentBalance.send(completion: .finished)
        currentBalance.send(10) // 3
    }

    /*
     PassthroughSubject does not hold an initial value. It sends the value down the stream.
     */
    func testPassThroughSubject() {
        let currentBalance = PassthroughSubject<Int, Never>()

        _ = currentBalance.sink(receiveCompletion: { completion in
            print("completion: \(completion)")
        }, receiveValue: {value in
            print("value: \(value)")
        })

        currentBalance.send(10)
        currentBalance.send(completion: .finished)
    }
}
