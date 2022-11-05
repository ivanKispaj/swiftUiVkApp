//
//  FriendsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI


struct FriendsScene: View {
    @State private var friends: [Friends] = [
        Friends(name: "Путин", imageName: "flag.2.crossed"),
        Friends(name: "Шольц", imageName: "mic"),
        Friends(name: "Квазимода", imageName: "network.badge.shield.half.filled"),
        Friends(name: "Радищев", imageName: "figure.walk")
    ]
    
    @State var nextDestination: String = ""
    @State var selection = false
   // @State private var isPresent = false
    var body: some View {
        NavigationStack(root: {
            ZStack {
                List(friends) { friends in
                            FriendsCellView(friends: friends)
  
                }
                .listStyle(.plain)
            }
           
        })
    }
}

