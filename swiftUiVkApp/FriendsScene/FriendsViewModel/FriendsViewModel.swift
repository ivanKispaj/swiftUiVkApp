//
//  FriendsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 05.11.2022.
//

import Foundation
import RealmSwift
import Realm

struct GroupedFiends: Hashable {
    static func == (lhs: GroupedFiends, rhs: GroupedFiends) -> Bool {
        return lhs.header == rhs.header && lhs.rows == rhs.rows
    }
    
    let header: String
    var rows: [Friend]
}

final class FriendsViewModel: ObservableObject {
    
    var loadSerivce: (any VKLoadInterface)? = nil
    var paeseInterface: FriendsParseInterface? = nil
    @Published var groupedFiends: [GroupedFiends] = []
    
    //MARK: - create friends data with grouped for first char in name
    
    func loadFriends( userId: String, token: String, count: String = "20" ) {
        
        self.paeseInterface = FriendsParse()
        self.loadSerivce = LoadFromVk<Friends>(token: token, path: .getFriends)
        
        let query = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: count),
            URLQueryItem(name: "fields", value: "photo_50, city, last_seen, online, status "),
            URLQueryItem(name: "v", value: "5.131")
            
        ]
        
        self.loadSerivce?.load(to: userId, query: query, completion: { response, error in
            if let friends = response as? Friends {
                self.paeseInterface?.parse(from: friends.response, completion: { friends in
                    self.setGroupedFriends(from: friends)
                })
            }
        })
    }
    
    
    private func setGroupedFriends(from friends: [Friend]) {
        var grouped: [GroupedFiends] = []
        for friend in friends {
            if let char = (friend.userName.components(separatedBy: " ")[0].first) {
                let str = String(char)
                if let index = grouped.firstIndex(where: {$0.header == str}) {
                    grouped[index].rows.append(friend)
                } else {
                    grouped.append(GroupedFiends(header: str, rows: [friend]))
                }
            }
            DispatchQueue.main.async {
                self.groupedFiends = grouped.sorted(by: {$0.header < $1.header})
                
            }
        }
    }
}

