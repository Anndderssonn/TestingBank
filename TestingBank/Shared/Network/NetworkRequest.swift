//
//  NetworkRequest.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

struct NetworkRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?
    
    init(url: String, method: HTTPMethod, headers: [String : String] = [:], body: Data? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}
