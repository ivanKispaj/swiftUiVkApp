//
//  NewsSceneView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI



struct NewsSceneView: View {
    
    @State private var isSideBarOpened = false
    var body: some View {
        
        ZStack {
            NavigationView {
                Text("News Scene")
                    .listStyle(.inset)
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            
            SidebarMenu(isSidebarVisible: $isSideBarOpened)
        }
    }
    
}



struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showMenu = true
            }
        }) {
            Text("Show Menu")
        }
    }
}



