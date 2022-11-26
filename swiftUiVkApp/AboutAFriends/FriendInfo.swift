//
//  FriendInfo.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 21.11.2022.
//

import SwiftUI

struct FriendInfo: View {
    @State var friend: Friend
    
    var body: some View {
        ZStack {
            Text(friend.userName)
        }
        .navigationTitle(friend.userName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
