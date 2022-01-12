//
//  File.swift
//  
//
//  Created by Pedro Farina on 19/12/21.
//

@testable import EndpointsRequests

/// A mocked HTTPProvider. It delegates the responsibility of the handler completion to the test case by using handlers.
public class MockProvider: HTTPProvider {
    public typealias HTTPHandler = (HTTPResult) -> Void
    public typealias MockHandler = (HTTPRequest, HTTPHandler) -> Void


    private var nextHandlers = Array<MockHandler>()

    public func execute(request: HTTPRequest, completion: @escaping HTTPHandler) {
        if nextHandlers.isEmpty == false {
            let next = nextHandlers.removeFirst()
            next(request, completion)
        } else {
            let error = HTTPError(code: .cannotConnect, request: request)
            completion(.failure(error))
        }
    }

     /**
      It delegates the executing completion to the test case.
      ```
      let mock = MockProvider()
      mock.then { request, handler in
        XCTAssert(request.path, "foo/")
        handler(.success(...))
      }
      ```
      - Warning: A then action should be registered before executing requests
      */
    @discardableResult
    public func then(_ handler: @escaping MockHandler) -> MockProvider {
        nextHandlers.append(handler)
        return self
    }
}
