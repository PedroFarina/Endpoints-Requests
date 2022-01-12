//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public protocol HTTPProvider {
    func execute(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)
}

public final class DefaultHTTPProvider: HTTPProvider {
    public init() {
    }
    public func execute(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        guard let url = request.urlConstructor.url else {
            let error = HTTPError(code: .invalidRequest, request: request)
            triggerCompletion(on: request,
                              with: .failure(error),
                              completion: completion)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        urlRequest.feedHeader(with: request.headers)

        if !request.body.isEmpty {
            urlRequest.feedHeader(with: request.body.additionalHeaders)
            do {
                urlRequest.httpBody = try request.body.encode()
            } catch {
                let HTTPError = HTTPError(code: .failedToParse, request: request)
                triggerCompletion(on: request,
                                  with: .failure(HTTPError),
                                  completion: completion)
                return
            }
        }

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            let result = HTTPResult(request: request, responseData: data, response: response, error: error)
            if case .failure = result,
               let timeInterval = request.retryStrategy?.incrementAndGetRetryDelay(for: result) {
                request.targetQueue.asyncAfter(deadline: .now() + timeInterval) { [weak self] in
                    self?.execute(request: request, completion: completion)
                }
            } else {
                self?.triggerCompletion(on: request, with: result, completion: completion)
            }
        }
        dataTask.resume()
    }
    private func triggerCompletion(on request: HTTPRequest, with result: HTTPResult, completion: @escaping (HTTPResult) -> Void) {
        request.targetQueue.async {
            completion(result)
        }
    }
}
