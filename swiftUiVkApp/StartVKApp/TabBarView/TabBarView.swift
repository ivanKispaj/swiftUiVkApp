//
//  TabBarView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI


struct TabBarView: View {
    
    var body: some View {
        TabView {
            
            NewsSceneView()
                .badge(2)
                .tabItem {
                    Label("News", systemImage: "house.fill")
                }
            FriendsScene()
                .tabItem {
                    Label("Friends", systemImage: "person.2.badge.gearshape.fill")
                }
            GroupCell()
                .badge("!")
                .tabItem {
                    Label("Groups", systemImage: "person.3.fill")
                }
        }
    }
}

