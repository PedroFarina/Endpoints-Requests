//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public typealias HTTPResult = Result<HTTPResponse, HTTPError>

public extension HTTPResult {
    init(request: HTTPRequest, responseData: Data?, response: URLResponse?, error: Error?) {
        var httpResponse: HTTPResponse?
        if let r = response as? HTTPURLResponse {
            httpResponse = HTTPResponse(request: request, response: r, data: responseData)
        }

        if let urlError = error as? URLError {
            let code: HTTPError.Code
            switch urlError.code {
                case .badURL, .cannotFindHost, .unsupportedURL:
                    code = .invalidRequest
                case .badServerResponse:
                    code = .invalidResponse
                case .cancelled, .userCancelledAuthentication:
                    code = .cancelled
                case .notConnectedToInternet, .networkConnectionLost, .cannotConnectToHost, .timedOut:
                    code = .cannotConnect
                case .secureConnectionFailed:
                    code = .insecureConnection
                default: code = .unknown
            }
            self = .failure(HTTPError(code: code, request: request, response: httpResponse, underlyingError: urlError))
        } else if let error = error {
            self = .failure(HTTPError(code: .unknown, request: request, response: httpResponse, underlyingError: error))
        } else if let httpResponse = httpResponse {
            self = .success(httpResponse)
        } else {
            self = .failure(HTTPError(code: .invalidResponse, request: request, underlyingError: error))
        }
    }

    var request: HTTPRequest {
        switch self {
            case .success(let response): return response.request
            case .failure(let error): return error.request
        }
    }

    var response: HTTPResponse? {
        switch self {
            case .success(let response): return response
            case .failure(let error): return error.response
        }
    }

}
