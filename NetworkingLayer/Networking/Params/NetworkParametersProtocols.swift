//
//  NetworkParametersProtocols.swift
//
//  Created by Tyler Wells
//

import Foundation

protocol BodyParametersEncodable {}
extension BodyParametersEncodable {
    func encode(request: inout URLRequest, with parameters: Data) {
        request.httpBody = parameters
    }
    
    func encode(request: inout URLRequest, with parameters: Encodable, contentType: HTTPContentType?) throws {
        guard let contentType = contentType else { throw NetworkErorr.contentTypeNil }
        switch contentType {
        case .json:
            do {
                let encodedParams = try parameters.encodeToJSONData()
                self.encode(request: &request, with: encodedParams)
            } catch {
                throw error
            }
        case .form:
            do {
                var characterSet = CharacterSet.alphanumerics
                characterSet.insert(charactersIn: "-._* ")
                let dictionaryEncodedParams = try parameters.encodeToJSONData()
                if let dictionary = try JSONSerialization.jsonObject(with: dictionaryEncodedParams, options: .allowFragments) as? [String: Any] {
                    let parametersArray = dictionary.map({key, value in
                        return "\(key)=" + "\(value)".addingPercentEncoding(withAllowedCharacters: characterSet)!
                            .replacingOccurrences(of: " ", with: "+")
                            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
                    })
                    if let data = parametersArray.joined(separator: "&").data(using: .utf8) {
                        self.encode(request: &request, with: data)
                    }
                }
            } catch {
                throw error
            }
        default:
            break
        }
        if request.value(forHTTPHeaderField: "Content-Type") == nil && contentType != .none {
            request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
    }
}
