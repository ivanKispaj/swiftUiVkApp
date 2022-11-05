//
//  FriendsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 05.11.2022.
//

import Foundation

final class FriendsViewModel: ObservableObject {
    
    let internetConnection: InternetConnections 
    @Published var friend: [Friend] = []
    
    init( internetConnection: InternetConnections = InternetConnections(path: .getFriends), friend: [Friend] = [] ) {
        self.friend = friend
        self.internetConnection = internetConnection
    }
}
