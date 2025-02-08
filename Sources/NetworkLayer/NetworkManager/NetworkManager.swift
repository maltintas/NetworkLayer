//
//  NetworkManager.swift
//  NetworkPlayground
//
//  Created by Mehmet Altıntaş on 2.02.2025.
//

import Foundation

public final class NetworkManager: Sendable {
    private let session: URLSession = .shared
    
    public func send<T: NetworkRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = try request.toURLRequest()
        
        let (data, response) = try await session.data(for: urlRequest)
        try validateResponse(response)
        
        return try decode(data: data, type: T.Response.self)
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
    }
    
    private func decode<T: Decodable>(data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
