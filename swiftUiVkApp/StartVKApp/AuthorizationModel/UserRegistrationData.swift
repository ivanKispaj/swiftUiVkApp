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
    let isUsedBiometrics: Bool
    let typeBiometric: BiometricType
    let authModel: AuthorizationModel
    var account: AccauntResponse?
    init(token: String, userId: String, isUsedBiometrics: Bool = false, typeBiometric: BiometricType = .none, authModel: AuthorizationModel, account: AccauntResponse?) {
        self.token = token
        self.userId = userId
        self.isUsedBiometrics = isUsedBiometrics
        self.typeBiometric = typeBiometric
        self.authModel = authModel
        self.account = account
    }
}
