//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public struct DataBody: HTTPBody {
    private let data: Data

    public var isEmpty: Bool { data.isEmpty }
    public var additionalHeaders: [String: String]

    public init(_ data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }

    public func encode() throws -> Data { data }
}
