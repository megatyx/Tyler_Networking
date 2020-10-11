//
//  NetworkOptions.swift
//
//  Created by Tyler Wells
//

import Foundation

struct NetworkOptions {
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    var timeoutInterval: TimeInterval = 10
}
