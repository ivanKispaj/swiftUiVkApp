//
//  FriendsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI
import UIKit


struct FriendsScene: View {
    
    @EnvironmentObject var userData: UserRegistrationData
    @ObservedObject var viewModel: FriendsViewModel
    @State private var isloadedFriend = false
    @State var isSelected = false
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack(root: {
            ZStack {
                List {
                    ForEach(self.viewModel.groupedFiends, id: \.self) { item in
                        Section(header:
                                    Text(item.header)
                        ){
                            ForEach(item.rows, id: \.self) { friend in
                                
                                FriendTableCell(friend: friend)
                                    .swipeActions(content: {
                                        VStack {
                                            Text("delite")
                                            Button(role: .destructive) {
                                                print("delite")
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                            .opacity(0.2)
                                            
                                        }
                                    })
                                 
                            }
                           
                        }
                    }
                    
                }
                .frame( maxWidth: .infinity)
                .listStyle(GroupedListStyle())
                
            }
            
            .navigationTitle("Друзья")
            .navigationBarTitleDisplayMode(.inline)
            
        })
        .onAppear {
            if !isloadedFriend {
                viewModel.internetConnection.loadFriends(for: userData.userId,token: userData.token) { response in
                    self.isloadedFriend.toggle()
                    DispatchQueue.main.async {
                        self.viewModel.setGroupedFriends(from: response)
                    }
                }
            }
        }
    }

}


struct LabelStyleCustom: View {
    
    var body: some View {
        VStack {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 10,height: 10)
            Text("pencile")
                .fontWeight(.ultraLight)
        }
        .frame(width: 50,height: 50)
    }
}


