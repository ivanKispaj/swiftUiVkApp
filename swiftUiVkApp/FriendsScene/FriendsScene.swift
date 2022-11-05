//
//  FriendsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import SwiftUI


struct FriendsScene: View {
    
  //  @State private var friends: [Friends] = []
    @ObservedObject var viewModel: FriendsViewModel
    @State var nextDestination: String = ""
    @State var selection = false
   // @State private var isPresent = false
    private var userId = UserDefaults.standard.string(forKey: AuthData.userId.rawValue)
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(root: {
            ZStack {
            
                List(self.viewModel.friend) { friend in
                            FriendsCellView(friend: friend)

                }
                .listStyle(.plain)
                
            }
            .navigationTitle("Друзья")
            .navigationBarTitleDisplayMode(.inline)
           
        })
      
        .onAppear {
            viewModel.internetConnection.loadFriends(for: userId!) { response in
                DispatchQueue.main.async {
                    self.viewModel.friend = response
                }
            }
                }
    }
}

