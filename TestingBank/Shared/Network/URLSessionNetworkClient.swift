//
//  URLSessionNetworkClient.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

struct URLSessionNetworkClient: NetworkClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform(_ request: NetworkRequest) async throws -> Data {
        guard let url = URL(string: request.url) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        let (data, response) = try await session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
