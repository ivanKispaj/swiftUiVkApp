//
//  NewsSceneView.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI
import VKApiMethods


struct NewsSceneView: View {
    @EnvironmentObject var userData: UserRegistrationData
    @State private var isSideBarOpened = false
    @State var text = ""
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
        .onAppear {
         
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



