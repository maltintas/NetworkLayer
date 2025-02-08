//
//  NetworkRequest.swift
//  NetworkPlayground
//
//  Created by Mehmet Altıntaş on 2.02.2025.
//

import Foundation

public protocol NetworkRequest {
    associatedtype Response: Decodable
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var queryItems: [String: Any?]? { get }
}

public extension NetworkRequest {
    var baseURL: String {
        "https://dummyjson.com"
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var body: Encodable? {
        nil
    }
    
    var queryItems: [String: Any?]? {
        nil
    }
    
    func buildURL() -> URL {
        var component = URLComponents()
        component.host = baseURL
        component.path = endpoint
        component.queryItems = Self.convertToURLQueryItems(dict: queryItems)
        
        guard let url = component.url else {
            preconditionFailure(NetworkError.invalidURL.localizedDescription)
        }
        
        return url
    }
    
    func toURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body?.data()
        
        return request
    }
}


extension NetworkRequest {
    static func convertToURLQueryItems(dict: [String: Any?]?) -> [URLQueryItem]? {
            guard let dict = dict else { return nil }
            
            return dict
                .filter { _, value in value != nil }
                .flatMap { key, value in Self.buildQueryItems(key: key, value: value) }
        }

        static func buildQueryItems(key: String, value: Any?) -> [URLQueryItem] {
            guard let value else {
                return [ URLQueryItem(name: key, value: nil) ]
            }

            switch value {
            case is String:
                return [ URLQueryItem(name: key, value: value as? String) ]
                
            case is Int,
                is Int32,
                is Bool,
                is Double,
                is Float:
                return [ URLQueryItem(name: key, value: String(describing: value)) ]
                
            case let value as [Any]:
                return value
                    .filter { false == ($0 is [Any]) }
                    .flatMap { Self.buildQueryItems(key: key, value: $0) }
                
            default:
                return []
            }
        }
}
