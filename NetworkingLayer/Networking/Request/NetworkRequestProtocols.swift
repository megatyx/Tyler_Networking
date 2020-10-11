//
//  NetworkRequestProtocols.swift
//
//  Created by Tyler Wells
//

import Foundation

protocol NetworkRequestBuildable: URLBuildable, BodyParametersEncodable, HTTPHeadersEncodable {}
extension NetworkRequestBuildable {
    func generateRequest(route: URL,
                         httpMethod: HTTPMethod,
                         httpContent: HTTPContentType,
                         parameters: Encodable?,
                         urlParameters: [String:Any]?,
                         cachePolicy: URLRequest.CachePolicy,
                         timeOutInterval: TimeInterval) throws -> URLRequest {
        
        do {
            let url = try buildURL(url: route, parameters: urlParameters)
            var request = URLRequest(url: url,
                                     cachePolicy: cachePolicy,
                                     timeoutInterval: timeOutInterval)
            request.httpMethod = httpMethod.rawValue
            if let parameters = parameters {
                try encode(request: &request, with: parameters, contentType: httpContent)
            }
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            return request
        } catch {
            throw error
        }
    }
    
    func generateRequest(route: String,
                         httpMethod: HTTPMethod,
                         httpContent: HTTPContentType,
                         parameters: Encodable?,
                         urlParameters: [String:Any]?,
                         cachePolicy: URLRequest.CachePolicy,
                         timeOutInterval: TimeInterval) throws -> URLRequest {
        
        do {
            let url = try buildURL(urlString: route)
            return try self.generateRequest(route: url, httpMethod: httpMethod, httpContent: httpContent, parameters: parameters, urlParameters: urlParameters, cachePolicy: cachePolicy, timeOutInterval: timeOutInterval)
        } catch {
            throw error
        }
    }
}
