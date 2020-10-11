//
//  NetworkHeadersProtocols.swift
//
//  Created by Tyler Wells
//

import Foundation

protocol HTTPHeadersEncodable {}
extension HTTPHeadersEncodable {
    func addHeaders(_ headers: [String:String]?, request: inout URLRequest) {
        guard let headers = headers else {return}
        for (key,value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
