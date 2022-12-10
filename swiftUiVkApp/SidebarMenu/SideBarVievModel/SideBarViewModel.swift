//
//  SideBarViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 20.11.2022.
//

import SwiftUI
import Combine

final class SideBarViewModel: ObservableObject {
    
    @Published var accountInfo: [AccauntResponse] = []
    
   
    private var subscriber = Set<AnyCancellable>()

    var secondaryColor: Color =
    Color(.init(
        red: 100 / 255,
        green: 174 / 255,
        blue: 255 / 255,
        alpha: 1))



    var userActions: [MenuItem] = [
        MenuItem(id: 4001, icon: "person.circle.fill", text: "My Account", isToggle: false),
        MenuItem(id: 4002, icon: "bag.fill", text: "Использовать FaceId?", isToggle: true),
    ]

    var profileActions: [MenuItem] = [
        MenuItem(id: 4003,
                 icon: "wrench.and.screwdriver.fill",
                 text: "Settings",isToggle: false),
        MenuItem(id: 9999,
                 icon: "door.right.hand.open",
                 text: "Logout", isToggle: false),
    ]
    
    var bgColor: Color = Color(.init(
        red: 52 / 255,
        green: 70 / 255,
        blue: 182 / 255,
        alpha: 1)
    )
    

}




