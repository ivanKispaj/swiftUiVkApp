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
            NavigationView {
                if  UserDefaults.standard.string(forKey: "token") != nil {
                    TabBarView()
                } else {
                    VKLoginView()
                }
            }
        }
    }
}

