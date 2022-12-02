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

final class ViewModelFriends: ObservableObject {
    @Published var groupedFiends: [GroupedFiends] = [] // Property for update virew
    private var service: any LoadServiceInterface = loadDataFromVk<Friends>()
    private var parseInterface: FriendsParseInterface = FriendsParse()
    
    func getFriends(token: String, userId: String) async {
        guard let friends = await service.load(userId: userId,apiMethod: .getAllFriends(token: token, userId: userId)) as? Friends else {
            groupedFiends = []
            return
        }
        self.parseInterface.parse(from: friends.response) { friends in
            self.setGroupedFriends(from: friends)
        }
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
        }
        if grouped.count != self.groupedFiends.count {
            DispatchQueue.main.async {
                self.groupedFiends = grouped.sorted(by: {$0.header < $1.header})
            }
        }
    }
}
