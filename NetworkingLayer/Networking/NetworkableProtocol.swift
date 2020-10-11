//
//  NetworkableProtocol.swift
//
//  Created by Tyler Wells on 8/23/20.
//

import Foundation
import SystemConfiguration

protocol Networkable: NetworkRequestBuildable {}
extension Networkable {
    func cancelTask(_ task: inout URLSessionTask?) {
        task?.cancel()
    }
    
    func resumeTask(_ task: inout URLSessionTask?) {
        task?.resume()
    }
    
    var isReachable: Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func networkRequest(session: URLSession,
                 route: URL,
                 httpMethod: HTTPMethod,
                 httpContent: HTTPContentType,
                 parameters: Encodable? = nil,
                 headers: [String:Any]? = nil,
                 networkControlOptions: NetworkOptions = NetworkOptions(),
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        do {
            let request = try self.generateRequest(route: route,
                                                   httpMethod: httpMethod,
                                                   httpContent: httpContent,
                                                   parameters: parameters,
                                                   urlParameters: headers,
                                                   cachePolicy: networkControlOptions.cachePolicy,
                                                   timeOutInterval: networkControlOptions.timeoutInterval)
            let task = session.dataTask(with: request, completionHandler: {completion($0,$1,$2)})

            task.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func networkRequest(task: inout URLSessionTask?,
                        session: URLSession,
                        route: String,
                        httpMethod: HTTPMethod,
                        httpContent: HTTPContentType,
                        parameters: Encodable? = nil,
                        headers: [String:Any]? = nil,
                        networkControlOptions: NetworkOptions = NetworkOptions(),
                        completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        do {
            let request = try self.generateRequest(route: route,
                                                   httpMethod: httpMethod,
                                                   httpContent: httpContent,
                                                   parameters: parameters,
                                                   urlParameters: headers,
                                                   cachePolicy: networkControlOptions.cachePolicy,
                                                   timeOutInterval: networkControlOptions.timeoutInterval)
            task? = session.dataTask(with: request, completionHandler: {completion($0,$1,$2)})
        } catch {
            completion(nil, nil, error)
        }
        self.resumeTask(&task)
    }
    
}
