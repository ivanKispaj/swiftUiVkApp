//
//  VKLoginView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 01.11.2022.
//

import SwiftUI

struct VKLoginView: View {
    @Binding var isUnlocked: Bool
    @State var isEnterCode: Bool = false
    @State var saveCode = false
    var authModel: AuthorizationModel
    private let pub = NotificationCenter.default
        .publisher(for: NSNotification.Name("vkTokenSaved"))
    
    var body: some View {
        
        if saveCode {
            Text("")
                .onAppear {
                    authModel.updateAuthData()
                    isUnlocked = true
                }
        } else {
            if isEnterCode {
                SetCodeAuthentificate(saveCode: $saveCode,bioType: authModel.biometricType)
            } else {
                ZStack {
                    VKLoginWebView()
                }
            }
            ZStack {
                
            }
            .onReceive(pub) { _ in
                authModel.updateAuthData()
                print(authModel.biometricType)
                self.isEnterCode = true
            }
        }
    }
}



