//
//  USRemoteConfigDataSource.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct USRemoteConfigDataSource: RemoteConfigDataSourceProtocol {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func fetchConfig() async throws -> RemoteConfigDTO {
        let request = NetworkRequest(
            url: "https://api.us.testingbank.com/v1/config",
            method: .GET,
            headers: ["Accept": "application/json"]
        )
        let data = try await client.perform(request)
        return try JSONDecoder().decode(RemoteConfigDTO.self, from: data)
    }
}
