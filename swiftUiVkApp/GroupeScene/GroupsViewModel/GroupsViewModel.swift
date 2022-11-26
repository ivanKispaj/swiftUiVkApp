//
//  GroupsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation



final class GroupsViewModel: ObservableObject {
    
    var loadSerivce: (any VKLoadInterface)? = nil
    
    let internetConnection: InternetLoadDataInterface
    @Published var groups: [ItemsGroup] = []
    
    init( internetConnection: InternetLoadDataInterface = InternetService(path: .getGroups) ) {
        self.internetConnection = internetConnection
    }
    
    func loadGroups(userId: String, token: String) {
        self.loadSerivce = LoadFromVk<UserGroupModel>(token: token, path: .getGroups)
        
        let query = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity, city, description, links, site, status "),
            URLQueryItem(name: "v", value: "5.131")
        ]
        self.loadSerivce?.load(to: userId, query: query, completion: { groups, error in
            
            if let result = groups as? UserGroupModel {
                DispatchQueue.main.async {
                    self.groups = result.response.items
                    
                }
            }
        })
    }
    
}
