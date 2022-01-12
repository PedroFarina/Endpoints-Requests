//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public struct HTTPRequest {

    public var urlConstructor: URLConstructor
    public var targetQueue: DispatchQueue = DispatchQueue(label: "httpRequest", qos: .background, target: .main)
    public var method: HTTPMethod = .get
    public var headers: HTTPHeader = [:]
    public var body: HTTPBody = EmptyBody()
    public var retryStrategy: HTTPRetryStrategy?

    public init(urlConstructor: URLConstructor) {
        self.urlConstructor = urlConstructor
    }
}
