//
//  JailBreakValidator.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

struct JailBreakValidator: StartupValidatorProtocol {
    func validate() async -> ValidationResultModel {
#if targetEnvironment(simulator)
        return .passed
#else
        let paths = [
            "/Applications/Cydia.app",
            "/usr/sbin/sshd",
            "/bin/bash",
        ]
        let isJailBroken = paths.contains { FileManager.default.fileExists(atPath: $0) }
        return isJailBroken ? .failed(.blocked(.jailBreak)) : .passed
#endif
    }
}
