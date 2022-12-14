//
//  Authorization.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 19.11.2022.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct  Authorization: View {
    
 
   
    
    enum AuthType: Hashable {
        case biometrics
        case code
        case none
    }
    
    @State var code: String = ""
    @ObservedObject private var authViewModel: AuthorizationModel = AuthorizationModel()
    @State var isUnlocked: Bool = false
    @State private var isRightCode = false
    @State var authType: AuthType = .none
    
    var body: some View {
        
        if authViewModel.token.isEmpty || authViewModel.userId.isEmpty || authViewModel.code.isEmpty {
            
                VKLoginView(authModel: authViewModel)

            
        } else {
            if authViewModel.isUnlocked {
                // UNLOCKED!
                TabBarView()
                    .environmentObject(UserRegistrationData(token: authViewModel.token, userId: authViewModel.userId, isUsedBiometrics: authViewModel.isBiometricAuthorization, typeBiometric: authViewModel.biometricType,authModel: self.authViewModel,account: authViewModel.accountInfo))
                    .task { [self] in
                        await self.authViewModel.getMyData(token: authViewModel.token, userId: authViewModel.userId)
                    }
            } else {
                
                switch authType {
                    
                case .biometrics:
                    //  BIOMETRICS AUTHORIZATION
                    VStack {
                        Text("Authentificate!")
                    }
                    .task {
                        await  self.authViewModel.authentificate { [self] result in
                            if !result {
                                authType = .code
                            }
                        }
                    }
                case .code:
                    // CODE AUTHORIZATION
                    if authViewModel.code.isEmpty {
                        SetCodeAuthentificate(authModel: self.authViewModel)
                    } else {
                        CodeAuthentificate( authModel: self.authViewModel)

                    }
                default:
                    ZStack {
                        Text("Авторизация")
                    }
                    .onAppear {
                       
                        self.authType = self.authViewModel.isBiometricAuthorization == true ? .biometrics : .code
                    }
                }
            }
        }
        
        
    }
 
    
}


