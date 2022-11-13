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
            FriendsScene(viewModel: FriendsViewModel())
                .tabItem {
                    Label("Friends", systemImage: "person.2.badge.gearshape.fill")
                }

            GroupsScene()
                .badge("!")
                .tabItem {
                    Label("Groups", systemImage: "person.3.fill")
                }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
            appearance.backgroundColor = UIColor(Color.cyan.opacity(0.2))
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
                
        
    }
}


