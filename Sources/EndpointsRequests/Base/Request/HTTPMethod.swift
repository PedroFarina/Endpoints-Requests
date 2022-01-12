//
//  File.swift
//  
//
//  Created by Pedro Farina on 17/12/21.
//

public struct HTTPMethod: Hashable {
    public let rawValue: String

    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let delete = HTTPMethod(rawValue: "DELETE")

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
