//
//  FriendsParse.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation

protocol FriendsParseInterface: AnyObject {
    func parse(from response: FriendsResponse, completion: @escaping([Friend]) -> Void)
}

final class FriendsParse: FriendsParseInterface {

    func parse(from response: FriendsResponse, completion: @escaping([Friend]) -> Void) {
        var arrays = [Friend]()
        let items = response.items
        for friendData in items {
            let friends = Friend()
            friends.countFriends = response.countFriends
            if friendData.online == 1 {
                friends.online = true
            }
            
            if friendData.banned != nil {
                friends.isBanned = true
            }
            
            if friendData.city != nil {
                friends.city = friendData.city!.title
            } else {
                friends.city = "unknown"
            }
            
            if friendData.lastSeen != nil {
                friends.lastSeenDate = friendData.lastSeen!.time
            }
            
            if  let status = friendData.status {
                friends.status = status
            }
            
            let name = (friendData.fName) + " " + (friendData.lName)
            friends.userName = name
            friends.id = friendData.id
            friends.photo = friendData.photo50
            friends.isClosedProfile = friendData.isClosedProfile
            arrays.append(friends)
        }
        completion(arrays)
    }
}


