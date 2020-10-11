//
//  NetworkURLProtocols.swift
//
//  Created by Tyler Wells
//

import Foundation

protocol URLBuildable {}
extension URLBuildable {
    func encodeURLQueryParams(_ urlParameters: [String:Any], to url: URL) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw NetworkErorr.urlParametersEncodingFailure }
        urlComponents.queryItems = urlParameters.map({return URLQueryItem(name: $0, value: "\($1)")})
        guard let newURL = urlComponents.url else { throw NetworkErorr.urlParametersEncodingFailure }
        return newURL
    }
    
    func buildURL(base: String, path: String, parameters: [String:Any]? = nil) throws -> URL {
        guard let url = URL(string: base + path) else { throw NetworkErorr.urlCastingFailure }
        do {
            return (parameters != nil) ? try encodeURLQueryParams(parameters!, to: url):url
        } catch {
            throw error
        }
    }
    
    func buildURL(base: URL, path: String, parameters: [String:Any]? = nil) throws -> URL {
        let url = base.appendingPathComponent(path)
        do {
            return (parameters != nil) ? try encodeURLQueryParams(parameters!, to: url):url
        } catch {
            throw error
        }
    }
    
    func buildURL(urlString: String, parameters: [String:Any]? = nil) throws -> URL {
        guard let url = URL(string: urlString) else { throw NetworkErorr.urlCastingFailure }
        do {
            return (parameters != nil) ? try encodeURLQueryParams(parameters!, to: url):url
        } catch {
            throw error
        }
    }
    
    func buildURL(url: URL, parameters: [String:Any]? = nil) throws -> URL {
        do {
            return (parameters != nil) ? try encodeURLQueryParams(parameters!, to: url):url
        } catch {
            throw error
        }
    }
}
