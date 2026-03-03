//
//  CARemoteConfigDataSource.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct CARemoteConfigDataSource {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchConfig() async throws -> RemoteConfigDTO {
        let request = NetworkRequest(
            url: "https://api.ca.testingbank.com/v1/config",
            method: .GET,
            headers: ["Accept": "application/json"]
        )
        let data = try await client.perform(request)
        return try JSONDecoder().decode(RemoteConfigDTO.self, from: data)
    }
}
