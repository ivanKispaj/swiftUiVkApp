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

        
        //        let drag = DragGesture()
        //            .onEnded {
        //                if $0.translation.width < -50 {
        //                    withAnimation {
        //                        self.showMenu = false
        //                    }
        //                }
        //            }
        //
        //        return NavigationView {
        //            GeometryReader { geometry in
        //                ZStack(alignment: .leading) {
        //                    MainView(showMenu: self.$showMenu)
        //                        .frame(width: geometry.size.width, height: geometry.size.height)
        //                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
        //                        .disabled(self.showMenu ? true : false)
        //                    if self.showMenu {
        //                        MenuView()
        //                            .frame(width: geometry.size.width - geometry.size.width / 4)
        //                            .transition(.move(edge: .leading))
        //                    }
        //                }
        //                    .gesture(drag)
        //            }
        //                .navigationBarTitle("Side Menu", displayMode: .inline)
        //                .navigationBarItems(leading: (
        //                    Button(action: {
        //                        withAnimation {
        //                            self.showMenu.toggle()
        //                        }
        //                    }) {
        //                        Image(systemName: "line.horizontal.3")
        //                            .imageScale(.large)
        //                    }
        //                ))
        //        }
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



