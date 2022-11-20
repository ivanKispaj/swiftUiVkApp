//
//  MenuModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 20.11.2022.
//

import Foundation

struct MenuItem: Identifiable {
    var id: Int
    var icon: String
    var text: String
    var isToggle: Bool
}

