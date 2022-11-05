//
//  FriendsModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 30.10.2022.
//

import Foundation

class Friends: Identifiable, Hashable {
    

    
    internal init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName }
    let id: UUID = UUID()
    let name: String
    let imageName: String
    
    static func == (lhs: Friends, rhs: Friends) -> Bool {
        return lhs.name == rhs.name && lhs.imageName == rhs.imageName && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageName)
    }
}

