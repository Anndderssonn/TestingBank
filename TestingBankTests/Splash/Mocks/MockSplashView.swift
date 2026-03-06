//
//  MockSplashView.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockSplashView: SplashViewDelegate {
    var showLoadingWasCalled = false
    var showBlokedScreenWasCalled = false
    var blockReasonReceived: BlockReasonModel?
    
    func showLoading() {
        showLoadingWasCalled = true
    }
    
    func showBlokedScreen(reason: BlockReasonModel) {
        showBlokedScreenWasCalled = true
        blockReasonReceived = reason
    }
}
