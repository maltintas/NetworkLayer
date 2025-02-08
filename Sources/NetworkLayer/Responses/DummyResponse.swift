//
//  DummyResponse.swift
//  NetworkPlayground
//
//  Created by Mehmet Altıntaş on 2.02.2025.
//

import Foundation

struct DummyResponse: Decodable {
    let todos: [DummyTODOModel]?
}

struct DummyTODOModel: Decodable {
    let id: Int?
    let todo: String?
    let userId: Int?
    let completed: Bool?
}
