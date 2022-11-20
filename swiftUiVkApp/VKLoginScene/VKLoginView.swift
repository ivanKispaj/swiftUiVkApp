//
//  VKLoginView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 01.11.2022.
//

import SwiftUI

struct VKLoginView: View {

    @State var isEnterCode: Bool = false
    var authModel: AuthorizationModel
    private let pub = NotificationCenter.default
        .publisher(for: NSNotification.Name("vkTokenSaved"))
    
    var body: some View {
        ZStack {
            
            if isEnterCode {
                SetCodeAuthentificate(authModel: self.authModel)
            } else {
                VKLoginWebView()
            }
        }
        .onReceive(pub) { _ in
            authModel.updateAuthData()
            print(authModel.biometricType)
            self.isEnterCode = true
        }
    }
}




