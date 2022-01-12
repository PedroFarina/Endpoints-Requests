//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

import Foundation

public final class ConstantRetry: HTTPRetryStrategy {
    public let delay: TimeInterval
    public let maximumNumberOfAttempts: Int
    internal var numberOfAttemptsLeft: Int

    init(delay: TimeInterval = 1, maximumNumberOfAttempts: Int = 3) {
        self.delay = delay
        self.maximumNumberOfAttempts = maximumNumberOfAttempts
        self.numberOfAttemptsLeft = maximumNumberOfAttempts
    }

    public func incrementAndGetRetryDelay(for result: HTTPResult) -> TimeInterval? {
        guard numberOfAttemptsLeft > 0 else {
            return nil
        }
        numberOfAttemptsLeft -= 1
        return delay
    }
}
