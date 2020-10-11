//
//  APIError.swift
//
//  Created by Tyler Wells
//

import Foundation

enum APIError: Error {
    case networkUnavailable
    case noJSONDataReturned
    
    //Generics
    case unknown
    case urlCasting
    case invalidParameters
    
    //Data Specific
    case payloadParse
    case dictionaryParse
    case dataParseInvalidTimeStamp
    case unsuccessfulPayload
    case decodableParse
    
    //Response Specific
    case unknown200
    case unknown300
    case unknown400
    case unknown500
    case internalServerError
    case notFound
    case noResponse
    case forbidden
    case noDataReturned
    case badRequest
    
    //Device Specific
    case unreachableInternetDisabled
    
    var description: String {
        switch self {
        case .unknown, .unknown200, .unknown300, .unknown400, .unknown500:
            return "Unknown Error"
        case .badRequest:
            return "Request could not be processed"
        case .payloadParse:
            return "JSON payload from the server couldn't be parsed into specified data stucture"
        case .decodableParse:
            return "JSON payload from the server couldn't be parsed into specified Decodable Object"
        case .dictionaryParse:
            return "JSON payload could not conform to Dicionary -> [String:Any]"
        case .internalServerError:
            return "Internal Server Error"
        case .notFound:
            return "Not Found"
        case .noResponse:
            return "Server Unreachable"
        case .forbidden:
            return "Forbidden"
        case .urlCasting:
            return "Unable to cast URL correctly"
        case .unreachableInternetDisabled:
            return "Network call unreachable due to device internet settings being disabled"
        case .dataParseInvalidTimeStamp:
            return "Timestamp is missing or improperly parsed"
        case .unsuccessfulPayload:
            return "JSON payload indicates failure in the return"
        case .invalidParameters:
            return "Invalid parameters passed to the API function"
        case .networkUnavailable:
            return "Network unavailable"
        case .noJSONDataReturned:
            return "No JSON"
        case .noDataReturned:
            return "No Valid Data Returned"
        }
    }
}
