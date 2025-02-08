//
//  NetworkError.swift
//  NetworkPlayground
//
//  Created by Mehmet Altıntaş on 2.02.2025.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingFailed
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Geçersiz URL"
        case let .statusCode(code): return "Hata Kodu: \(code)"
        case .invalidResponse: return "Invalid Response"
        case .decodingFailed: return "Decoding Failed"
        case let .custom(message): return message
        }
    }
}
