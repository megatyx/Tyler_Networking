//
//  NetworkError.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/23/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

enum NetworkErorr: Error {
    case urlParametersEncodingFailure
    case urlCastingFailure
    case contentTypeNil
}
