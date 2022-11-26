//
//  GroupsScene.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation
import SwiftUI

struct GroupsScene: View {
    private var rowHeight: CGFloat = 80
    
    @EnvironmentObject var userData: UserRegistrationData
    @ObservedObject var service: GroupsViewModel = GroupsViewModel()
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                List(service.groups) { group in
                    
                    GroupTableCell(groupName: group.groupName, logo: group.photoGroup, rowHeight: self.rowHeight)
                        .swipeAction(leading: [
                            SwipeItem(image: {
                                Image(systemName: "trash")
                            },label: {
                                Text("Delite")
                            } , action: {
                                print("Delite")
                            }, itemColor: .blue)
                            
                        ],
                                     rowHeight: self.rowHeight)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    
                    
                    
                }
                .listStyle(GroupedListStyle())
                
            }
            .navigationTitle("Groups")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onAppear {
            
            service.loadGroups(userId: userData.userId, token: userData.token)
        }
    }
}


