//
//  UserRegistrationData.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 19.11.2022.
//

import Foundation

final class UserRegistrationData: ObservableObject {
    let token: String
    let userId: String
    let isUsedBiometrics: Bool = false
    
    init(token: String, userId: String) {
        self.token = token
        self.userId = userId
    }
}
