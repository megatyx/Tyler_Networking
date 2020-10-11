//
//  EncodableExtensions.swift
//  Created by Tyler Wells
//

import Foundation
extension Encodable {
    func encodeToJSONData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            return try encoder.encode(self)
        } catch {
            throw error
        }
    }
    
    func encodeJSONToDictionary(readingOptions options: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: options) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
