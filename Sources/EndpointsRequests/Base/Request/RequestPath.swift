//
//  File.swift
//  
//
//  Created by Pedro Farina on 19/12/21.
//

import Foundation

public struct URLConstructor {

    private let components: URLComponents
    public var scheme: String? {
        components.scheme
    }
    public var host: String? {
        components.host
    }
    public var path: String {
        components.path
    }
    public private(set) var parameters: [String: Any] = [:]
    public private(set) var allowedCharacters: CharacterSet = .urlQueryAllowed

    /// Constructor for a path with separated components
    public init(scheme: String = "https", host: String, path: String = "") {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        self.components = components
    }

    /// Adds query parameters to the request path.
    @discardableResult public mutating func with(parameters: [String: Any]) -> Self {
        self.parameters = parameters
        return self
    }

    /// Adds one query parameter to the request path
    /// - Warning: Overrides previous value for key if already added.
    @discardableResult public mutating func adding(parameter: String, value: Any) -> Self {
        self.parameters[parameter] = value
        return self
    }
    /// Defines the allowed characters in encoding the URL's query
    @discardableResult public mutating func allowing(characterSet: CharacterSet) -> Self {
        self.allowedCharacters = characterSet
        return self
    }

    /// Builds the URL
    public var url: URL? {
        let path = components.string ?? ""
        var query = ""
        if !parameters.isEmpty {
            for parameter in parameters {
                query += "\(parameter.key)=\(parameter.value)&"
            }
            query = String(query.dropLast()).addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? query
            query = "?" + query
        }
        return URL(string: path + query)
    }
}
