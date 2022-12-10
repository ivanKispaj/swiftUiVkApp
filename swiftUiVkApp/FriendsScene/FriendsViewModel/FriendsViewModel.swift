//
//  FriendsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 05.11.2022.
//

import Foundation
import RealmSwift
import Realm
import Combine
import VKApiMethods


struct GroupedFiends: Hashable {
    static func == (lhs: GroupedFiends, rhs: GroupedFiends) -> Bool {
        return lhs.header == rhs.header && lhs.rows == rhs.rows
    }
    
    let header: String
    var rows: [Friend]
}

final class ViewModelFriends: ObservableObject {
    
    @Published var groupedFiends: [GroupedFiends] = [] // Property for update view
  
    private var parseInterface: FriendsParseInterface = FriendsParse()
    private var database: DBInterface = DBRealm()
    private var loadService: LoadServiceInterface = LoadFromInternet()
        
    private var subscriber = Set<AnyCancellable>()
  
    //MARK: - Получает пользователей из DB
    func loadFriendsFromDB(userId: String) async   {
        database.printConfiguration()
            await database.load(for: FriendsResponse.self, apiMethod: .getAllFriends(token: "", userId: userId))
            .first(where: { $0.id == Int(userId)
            })
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                }, receiveValue: { result in
                    
                    self.parseInterface.parse(from: result) { frineds in
                        self.setGroupedFriends(from: frineds)
                    }
                })
                .store(in: &self.subscriber)
    }
 
    //MARK: - Получает пользователей из VKApi через интернет
    func loadFriendsFromInternet(token: String, userId: String, count: String = "") async {

        await loadService.load(for: Friends.self, apiMethod: .getCountFriends(token: token, userId: userId, count: count))
        
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { friend in
                DispatchQueue.main.async {
                    self.database.updateData(object: friend.response)

                }
                
                self.parseInterface.parse(from: friend.response) { frineds in
                    self.setGroupedFriends(from: frineds)
                }
            
                  })
            .store(in: &self.subscriber)
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
            // Если подгрузились новые друзья то обновляем View
            let sorted = grouped.sorted(by: {$0.header < $1.header})
            DispatchQueue.main.async {
                self.groupedFiends = sorted
            }
        }
    }
}


