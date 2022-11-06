//
//  FriendsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI



struct FriendsScene: View {
    
    @ObservedObject var viewModel: FriendsViewModel
    @State var nextDestination: String = ""
    @State var selection = false
    @State private var isloadedFriend = false
    private var userId = UserDefaults.standard.string(forKey: AuthData.userId.rawValue)
    
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
                                    FriendsCellView(friend: friend)
                            }
                            .listRowBackground(Color.gray.opacity(0.2))
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
            if isloadedFriend {
                
            } else {
                viewModel.internetConnection.loadFriends(for: userId!) { response in
                    self.isloadedFriend.toggle()
                    DispatchQueue.main.async {
                        self.viewModel.setGroupedFriends(from: response)
                    }
                }
            }
        }
    }
}

