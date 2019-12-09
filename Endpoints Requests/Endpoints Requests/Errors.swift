//
//  Errors.swift
//  Endpoints Requests
//
//  Created by Pedro Giuliano Farina on 09/12/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

protocol MyErrorProtocol: LocalizedError {
    var title: String? { get }
}

struct NotURLError: MyErrorProtocol {
    var title: String?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid parse to URL."
        self._description = description
    }
}

struct InvalidCodableError: MyErrorProtocol {
    var title: String?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid Codable Object."
        self._description = description
    }
}

