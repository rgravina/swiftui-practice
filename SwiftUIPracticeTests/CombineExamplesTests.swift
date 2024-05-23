import Foundation
import XCTest
import Combine
import Nimble

@testable import SwiftUIPractice

/*
 More examples from the "Patterns and Recipes" section of this book. Sometimes I have modified them slightly.
  - The free Using Combine book by Joseph Heck https://heckj.github.io/swiftui-notes/
 */
final class CombineExampleTests: XCTestCase {
    /*
     Making a network request with dataTaskPublisher
     */
    func testDataTaskPublisher() {
        print("================")
        let expectation = expectation(description: "waiting for request")
        let myURL = URL(string: "https://postman-echo.com/time/valid?timestamp=2024-05-18")
        // checks the validity of a timestamp - this one returns {"valid":true}
        // matching the data structure returned from https://postman-echo.com/time/valid
        struct PostmanEchoTimeStampCheckResponse: Decodable, Hashable {
            let valid: Bool
        }

        let remoteDataPublisher = URLSession.shared.dataTaskPublisher(for: myURL!)
            // the dataTaskPublisher output combination is (data: Data, response: URLResponse)
            .map { $0.data }
            .decode(type: PostmanEchoTimeStampCheckResponse.self, decoder: JSONDecoder())

        var cancellable =  Set<AnyCancellable>()

        remoteDataPublisher
            .sink(receiveCompletion: { completion in
                    print(".sink() received the completion", String(describing: completion))
                    switch completion {
                        case .finished:
                            expectation.fulfill()
                            break
                        case .failure(let anError):
                            print("received error: ", anError)
                    }
            }, receiveValue: { someValue in
                print(".sink() received \(someValue)")
            }).store(in: &cancellable)

        wait(for: [expectation])
        print("================")
    }

    /*
     Wrapping an async call with a Future
     
     1) Create a Future with return type and error, and pass a closure.
     2) Call your async API like normal
     3) In the completion handler, use promise(.failure(<FailureType>)) for errors
     4) In the completion handler, use promise(.success(<OutputType>)) for success
     */
    func testFutures() {
        print("================")
        let expectation = expectation(description: "waiting for callback")
        func callMeBackLater(callback: @escaping (_ message: String, _ error: Error?) -> Void) {
            Task {
                sleep(1)
                callback("Hello from the future!", nil)
            }
        }

        let useFutures = Future<String, Error> { promise in // 1
            callMeBackLater { result, error in // 2
                if let error = error { // 3
                    return promise(.failure(error))
                }
                return promise(.success(result)) // 4
            }
        }.eraseToAnyPublisher()

        var cancellable =  Set<AnyCancellable>()

        useFutures
            .sink(receiveCompletion: { completion in
                print(completion)
                expectation.fulfill()
            }, receiveValue: { message in
                print(message)
            }).store(in: &cancellable)

        wait(for: [expectation])
        print("================")
    }
}
