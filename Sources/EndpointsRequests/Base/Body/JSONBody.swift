//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public struct JSONBody: HTTPBody {
    public let isEmpty: Bool = false
    public var additionalHeaders = [
        "Content-Type": "application/json; charset=utf-8"
    ]
    private let _encode: () throws -> Data

    public init<T: Encodable>(_ value: T, encoder: JSONEncoder = JSONEncoder()) {
        self._encode = { try encoder.encode(value) }
    }

    public func encode() throws -> Data { try _encode() }
}
