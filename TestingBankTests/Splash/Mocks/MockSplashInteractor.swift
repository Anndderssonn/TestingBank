//
//  MockSplashInteractor.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockSplashInteractor: SplashInteractorDelegate {
    var startUpWasCalled = false
    
    func startUp() {
        startUpWasCalled = true
    }
}
