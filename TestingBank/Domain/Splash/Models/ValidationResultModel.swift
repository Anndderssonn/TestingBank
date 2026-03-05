//
//  ValidationResult.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

enum ValidationResultModel: Equatable {
    case passed
    case failed(StartupResultModel)
}
