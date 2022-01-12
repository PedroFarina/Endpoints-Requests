//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public protocol HTTPRetryStrategy {
    /// Consumes one retry and get the delay expected for the next retry. If it returns nil, means it shouldn't retry.
    func incrementAndGetRetryDelay(for result: HTTPResult) -> TimeInterval?
}
