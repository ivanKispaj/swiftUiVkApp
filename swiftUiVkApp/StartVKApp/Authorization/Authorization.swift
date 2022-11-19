//
//  Authorization.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 19.11.2022.
//

import Foundation
import SwiftUI
import LocalAuthentication

struct Authorization: View {
    enum AuthType: Hashable {
        case biometrics
        case code
        case none
    }
    
    @State var code: String = ""
    @ObservedObject private var authViewModel: AuthorizationModel = AuthorizationModel()
    @State private(set) var isUnlocked: Bool = false
    @State private var isRightCode = false
    @State var authType: AuthType = .none
    
    var body: some View {
        
        if authViewModel.token.isEmpty {
                VKLoginView(isUnlocked: $isUnlocked, authModel: authViewModel)

            
        } else {
            if authViewModel.isUnlocked {
                // UNLOCKED!
                TabBarView()
                    .environmentObject(UserRegistrationData(token: authViewModel.token, userId: authViewModel.userId))
                
            } else {
                
                switch authType {
                    
                case .biometrics:
                    //  BIOMETRICS AUTHORIZATION
                    VStack {
                        Text("Authentificate!")
                    }
                    .task {
                        await  self.authViewModel.authenticate { result in
                            if !result {
                                authType = .code
                            }
                        }
                    }
                case .code:
                    // CODE AUTHORIZATION
                    CodeAuthentificate( authModel: self.authViewModel)//, isUnlocked: $isUnlocked)
                default:
                    ZStack {
                        Text("Авторизация")
                    }
                    .onAppear {
                        self.authType = self.authViewModel.isbiometricAuthorization == true ? .biometrics : .code
                    }
                }
            }
        }
        
        
    }
    
}


