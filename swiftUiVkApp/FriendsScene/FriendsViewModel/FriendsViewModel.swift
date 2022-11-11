//
//  FriendsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 05.11.2022.
//

import Foundation

struct GroupedFiends: Hashable {
    static func == (lhs: GroupedFiends, rhs: GroupedFiends) -> Bool {
        return lhs.header == rhs.header && lhs.rows == rhs.rows
    }
    
  let header: String
  var rows: [Friend]
}

final class FriendsViewModel: ObservableObject {
    
    let internetConnection: InternetConnections 
    @Published var groupedFiends: [GroupedFiends] = []
    init( internetConnection: InternetConnections = InternetConnections(path: .getFriends) ) {
        self.internetConnection = internetConnection
    }
  
    //MARK: - create friends data with grouped for first char in name
    func setGroupedFriends(from friends: [Friend]) {
        for friend in friends {
            if let char = (friend.userName.components(separatedBy: " ")[0].first) {
                let str = String(char)
                if let index = self.groupedFiends.firstIndex(where: {$0.header == str}) {
                    self.groupedFiends[index].rows.append(friend)
                } else {
                    groupedFiends.append(GroupedFiends(header: str, rows: [friend]))
                }
            }
            self.groupedFiends = self.groupedFiends.sorted(by: {$0.header < $1.header})
        }
    }
}

