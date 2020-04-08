//
//  Errors.swift
//  
//
//  Created by Pedro Giuliano Farina on 08/04/20.
//

import Foundation

public protocol MyErrorProtocol: LocalizedError {
    var title: String? { get }
}

public struct NotURLError: MyErrorProtocol {
    public var title: String?
    public var errorDescription: String? { return _description }
    public var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid parse to URL."
        self._description = description
    }
}

public struct InvalidCodableError: MyErrorProtocol {
    public var title: String?
    public var errorDescription: String? { return _description }
    public var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid Codable Object."
        self._description = description
    }
}


public class test {
    public func kk() {
        EndpointsRequests.getRequest(url: "XD", completion: nil)
    }
}

