//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public protocol HTTPBody {
    var isEmpty: Bool { get }
    var additionalHeaders: HTTPHeader { get }
    func encode() throws -> Data
}

public extension HTTPBody {
    var isEmpty: Bool { false }
    var additionalHeaders: HTTPHeader { [:] }
}
