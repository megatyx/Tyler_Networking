//
//  NetworkEnums.swift
//
//  Created by Tyler Wells
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPContentType: String {
    case none = ""
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}
