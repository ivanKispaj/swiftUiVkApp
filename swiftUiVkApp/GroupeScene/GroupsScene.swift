//
//  GroupsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation
import SwiftUI

struct GroupsScene: View {
    @EnvironmentObject var userData: UserRegistrationData
    @ObservedObject var service: GroupsViewModel = GroupsViewModel()
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                List(service.groups) { group in
                    
                    GroupTableCell(groupName: group.groupName, logo: group.photoGroup,cellHeight: 50)
                        
                }
                .frame( maxWidth: .infinity)
                .listStyle(GroupedListStyle())
               
            }
            .navigationTitle("Groups")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onAppear {
            service.internetConnection.loadGroups(to: userData.userId, acces: userData.token) { groups in
                DispatchQueue.main.async {
                    self.service.groups = groups
                    
                }
            }
        }
    }
}



