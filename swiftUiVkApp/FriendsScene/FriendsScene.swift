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
    private var rowHeight: CGFloat = 80
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack(root: {
              
                List {
                    ForEach(self.viewModel.groupedFiends, id: \.self) { item in
                        Section(header:
                                    Text(item.header)
                        ){
                            ForEach(item.rows, id: \.self) { friend in
                                
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
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                
                            }
                           
                        }
                    }
                    
                }
            
                .navigationTitle("Друзья")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(GroupedListStyle())
                    
            
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
        .frame(width: 10,height: 10)
    }
}


