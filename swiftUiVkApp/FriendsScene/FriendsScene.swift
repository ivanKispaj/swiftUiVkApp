//
//  FriendsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI
import UIKit


struct FriendsScene: View {
    @State private var isSideBarOpened = false
    @EnvironmentObject var userData: UserRegistrationData
    @StateObject var viewModel = ViewModelFriends()
    @State private var isloadedFriend = false
    private var rowHeight: CGFloat = 80

    
    var body: some View {
        ZStack {
            NavigationStack(root: {
                
                List {
                    ForEach(self.viewModel.groupedFiends, id: \.self) { item in
                        Section(header:
                                    Text(item.header)
                        ){
                            ForEach(item.rows, id: \.self) { friend in
                                NavigationLink(destination:
                                                FriendInfo(friend: friend)
                            
                                ) {
                                    
                                    
                                    FriendTableCell(friend: friend, rowHeight: rowHeight)
                                        .swipeAction(leading: [
                                            SwipeItem(
                                                image: {
                                                    Image(systemName: "trash")
                                                }, label: {
                                                    Text("Delite")
                                                }, action: {
                                                    print("delite")
                                                }, itemColor: .red)
                                            ,
                                            SwipeItem(image: {
                                                Image(systemName: "heart")
                                            },label: {
                                                Text("like")
                                            }, action: {
                                                print("like")
                                            },itemWidth: 60 ,itemColor: .red)
                                            ,
                                            
                                        ],rowHeight: self.rowHeight)
                                    
                                    
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 0))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                
                                
                            }
                        }
                        
                    }
                    
                }
                .navigationDestination(for: Friend.self, destination: { friend in
                    FriendInfo(friend: friend)
                })
                .navigationTitle("Друзья")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(GroupedListStyle())
                
                
            })
            .task {
                if !isloadedFriend {
                   await viewModel.loadFriendsFromDB(userId: userData.userId)
                   await   viewModel.loadFriendsFromInternet(token: userData.token, userId: userData.userId)
                }
            }
            SidebarMenu(isSidebarVisible: $isSideBarOpened)
        }
    }
    
}

