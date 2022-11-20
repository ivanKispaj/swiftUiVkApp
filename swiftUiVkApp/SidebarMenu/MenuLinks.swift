//
//  MenuLinks.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 20.11.2022.
//

import SwiftUI


struct MenuLinks: View {
    @EnvironmentObject var userData: UserRegistrationData

    var items: [MenuItem]
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(items) { item in
                if item.isToggle {
                    
                    if userData.typeBiometric == .faceID {
                        MenuLink(id: item.id, icon: "faceid", text: item.text,toggle: item.isToggle)
                    } else if userData.typeBiometric == .touchID {
                        MenuLink(id: item.id, icon: "touchid", text: item.text,toggle: item.isToggle)

                    } else {
                        MenuLink(id: item.id, icon: item.icon, text: item.text,toggle: item.isToggle)
                    }
                } else {
                    MenuLink(id: item.id,icon: item.icon, text: item.text)
                    

                }
            }
        }
        .padding(.vertical, 14)
        .padding(.leading, 8)
    }
}

