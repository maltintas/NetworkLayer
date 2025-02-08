//
//  DummyRequest.swift
//  NetworkPlayground
//
//  Created by Mehmet Altıntaş on 2.02.2025.
//

import Foundation

struct TODORequest: NetworkRequest {
    typealias Response = DummyResponse

    var endpoint: String = "/todos"
    var method: HTTPMethod = .get
}

struct TODOItemRequest: NetworkRequest {
    typealias Response = DummyTODOModel
    
    var id: Int
    var endpoint: String { return "/todos/\(id)" }
    var method: HTTPMethod = .get
}
