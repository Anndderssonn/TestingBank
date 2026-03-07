//
//  LoginRepositoryFactoryProtocol.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

protocol LoginRepositoryFactoryProtocol {
    func makeLoginRepository() -> any LoginRepository
}
