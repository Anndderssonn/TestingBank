//
//  StartupValidator.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

protocol StartupValidatorProtocol {
    func validate() async -> ValidationResultModel
}
