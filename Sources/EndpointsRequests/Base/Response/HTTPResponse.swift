//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public struct HTTPStatus: Hashable {
    public let rawValue: Int

    public static let ok = HTTPStatus(rawValue: 200)
    public static let created = HTTPStatus(rawValue: 201)
    public static let badRequest = HTTPStatus(rawValue: 400)
    public static let unauthorized = HTTPStatus(rawValue: 401)
    public static let forbidden = HTTPStatus(rawValue: 403)
    public static let notFound = HTTPStatus(rawValue: 404)
    public static let requestTimeout = HTTPStatus(rawValue: 408)
    public static let tooManyRequests = HTTPStatus(rawValue: 429)
    public static let internalServerError = HTTPStatus(rawValue: 500)
    public static let serviceUnavailable = HTTPStatus(rawValue: 503)
}

public struct HTTPResponse {
    public let request: HTTPRequest
    private let response: HTTPURLResponse
    public let data: Data?

    internal init(request: HTTPRequest, response: HTTPURLResponse, data: Data? = nil) {
        self.request = request
        self.response = response
        self.data = data
    }

    public var status: HTTPStatus {
        HTTPStatus(rawValue: response.statusCode)
    }

    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }

    public var headers: [AnyHashable: Any] { response.allHeaderFields }
}
