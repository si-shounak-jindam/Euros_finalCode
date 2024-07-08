//
//  URN.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

//MARK: Union Request Node
protocol URN {
    associatedtype Derived: Decodable
    var baseURLType: BaseURLType { get }
    var pathType: PathType { get }
    var httpMethodType: HTTPMethodType { get }
    var body: Data? { get }
    var urlQueryItems: [URLQueryItem]? { get }
    var pathExtension: String? { get }
    var headers: ServiceHeaderType? { get }
    func getURLRequest() throws -> URLRequest
}

protocol CommonURN: URN {}
extension CommonURN {
    
    var urlQueryItems: [URLQueryItem]? {
        .none
    }
    
    var pathExtension: String? {
        .none
    }
    
    var headers: ServiceHeaderType? {
        .DEFAULT
    }
    
    func getURLRequest() throws -> URLRequest {
        let urlComponents = URLComponents(string: baseURLType.baseUrlString
                                          + pathType.rawValue)
        guard let url = urlComponents?.url else {
            throw ServiceErrors.invalidUrlError(String(describing: pathType.self))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethodType.rawValue
        urlRequest.allHTTPHeaderFields = headers?.getServiceHeader(url: url.absoluteString)
        urlRequest.httpBody = body
        return urlRequest
    }
}

protocol CommonPostURN: CommonURN {}

extension CommonPostURN {
    var httpMethodType: HTTPMethodType {
        .post
    }
}

protocol CommonGetURN: CommonURN {}

extension CommonGetURN {
    var httpMethodType: HTTPMethodType {
        .get
    }
    
    var body: Data? {
        .none
    }
}

//protocol CommonGetDefaultURN: CommonGetURN {}
//
//extension CommonGetDefaultURN {
//    var headers: ServiceHeaderType? {
//        .DEFAULT
//    }
//}
