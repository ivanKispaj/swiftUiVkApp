//
//  GroupsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation



final class GroupsViewModel: ObservableObject {
    
 //   var loadSerivce: (any VKLoadInterface)? = nil
   // let internetConnection: InternetLoadDataInterface
    @Published var groups: [ItemsGroup] = []
    
    let service: any LoadServiceInterface = loadDataFromVk<UserGroupModel>()
    
//    init( internetConnection: InternetLoadDataInterface = InternetService(path: .getGroups) ) {
//        self.internetConnection = internetConnection
//    }
    
    func getGroups(userId: String, token: String) async {
        guard let groups = await service.load(userId: userId, apiMethod: .getGroups(token: token, userId: userId)) as? UserGroupModel else {
            groups = []
            return
        }
        if self.groups.count != groups.response.items.count {
            DispatchQueue.main.async {
                self.groups = groups.response.items

            }
        }
    }
}
