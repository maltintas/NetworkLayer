//
//  BaseResponse.swift
//  NetworkPlayground
//
//  Created by Mehmet Altıntaş on 2.02.2025.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool
    let data: T?
    let error: String?
}

struct PaginatedResponse<T: Decodable>: Decodable {
    let page: Int
    let totalPages: Int
    let results: [T]
}
