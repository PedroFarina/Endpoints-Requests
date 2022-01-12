import XCTest
@testable import EndpointsRequests

final class EndpointsRequestsTests: XCTestCase {
    func testExample() {
        let expectation = self.expectation(description: "Test Example")

        let mock = MockProvider()
        mock.then { request, handler in
            XCTAssertEqual(request.urlConstructor.path, "/foo")
            let urlResponse = HTTPURLResponse(url: request.urlConstructor.url!,
                                              statusCode: 200,
                                              httpVersion: "1.1",
                                              headerFields: nil)!
            let httpResponse = HTTPResponse(request: request, response: urlResponse, data: "Test".data(using: .utf8))
            handler(.success(httpResponse))
        }
        
        let urlConstructor = URLConstructor(scheme: "http", host: "pedrofarina.com.br", path: "/foo")
        let request = HTTPRequest(urlConstructor: urlConstructor)
        mock.execute(request: request) { result in
            XCTAssertNotNil(result.response)
            XCTAssertEqual(result.response!.status, .ok)
            XCTAssertNotNil(result.response!.data!)
            XCTAssertEqual(String(data: result.response!.data!, encoding: .utf8), "Test")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
