//
//  swiftUiVkAppApp.swift
//  swiftUiVkApp
//
//  Enter Point
//
//  Created by Ivan Konishchev on 18.10.2022.
//

import SwiftUI
import WebKit
@main
struct swiftUiVkAppApp: App {
    
    var body: some Scene {
        WindowGroup {
                if let token = UserDefaults.standard.string(forKey: "token"),
                   let userId = UserDefaults.standard.string(forKey: "userId")
                {
                    TabBarView()
                        .environmentObject(UserRegistrationData(token: token, userId: userId))
                } else {
                    VKLoginView()
                }
               
        }
    }
}


final class UserRegistrationData: ObservableObject {
    let token: String
    let userId: String
    
    init(token: String, userId: String) {
        self.token = token
        self.userId = userId
    }
}
