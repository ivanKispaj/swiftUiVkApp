//
//  GroupsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation



final class GroupsViewModel: ObservableObject {
    
    let internetConnection: InternetConnections
    @Published var groups: [ItemsGroup] = []
    
    init( internetConnection: InternetConnections = InternetConnections(path: .getGroups) ) {
        self.internetConnection = internetConnection
    }
}
