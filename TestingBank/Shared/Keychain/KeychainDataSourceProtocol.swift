//
//  KeychainDataSourceProtocol.swift
//  TestingBank
//
//  Created by Andersson on 5/03/26.
//

import Foundation

protocol KeychainDataSourceProtocol {
    func saveToken(_ token: String)
    func loadToken() -> String?
    func deleteToken()
}
