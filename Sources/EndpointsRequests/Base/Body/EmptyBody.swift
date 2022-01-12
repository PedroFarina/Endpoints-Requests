//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public struct EmptyBody: HTTPBody {
    public let isEmpty = true

    public init() { }
    public func encode() throws -> Data { Data() }
}
