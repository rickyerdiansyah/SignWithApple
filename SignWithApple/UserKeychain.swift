//
//  UserKeychain.swift
//  SignWithApple
//
//  Created by Ricky Erdiansyah on 28/11/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import Foundation
import AuthenticationServices

struct  Credentials {
    var username: String
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
    
}
