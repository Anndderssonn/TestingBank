//
//  MockSplashPresenter.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import Foundation
import XCTest
@testable import TestingBank

class MockSplashPresenter: SplashPresenterInteractorDelegate {
    var startUpCompletedWasCalled = false
    var resultReceived: StartupResultModel?
    
    func startUpCompleted(result: StartupResultModel) {
        startUpCompletedWasCalled = true
        resultReceived = result
    }
}
