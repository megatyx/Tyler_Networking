//
//  APIRoutes.swift
//
//  Created by Tyler Wells
//

import Foundation
enum APIRoutes: String {
    
    case getConfig = "config"
    
    var baseURL: String {
        return ""
    }
    
    var route: String {
        return baseURL + self.rawValue
    }
}
