//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public typealias HTTPHeader = [String: String]

internal extension URLRequest {
    mutating func feedHeader(with header: HTTPHeader) {
        for headerValue in header {
            setValue(headerValue.value, forHTTPHeaderField: headerValue.key)
        }
    }
}
