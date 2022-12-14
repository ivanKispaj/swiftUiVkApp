//
//  SideBarModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 04.12.2022.
//

import Foundation

final class MyAccount: Decodable {
    let response: [AccauntResponse]
}

final class AccauntResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
      //  case nickname
        case avatar = "photo_50"
        case fName = "first_name"
        case lName = "last_name"
        case status
        case screenName = "screen_name"
    }
    
    var id: Int = 0
    var nickname: String = ""
    var avatar: String = ""
    var fullName: String = ""
    var status: String = ""
    var screenName: String = ""
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
      //  self.nickname = try container.decode(String.self, forKey: .nickname)
        self.avatar = try container.decode(String.self, forKey: .avatar)
        let fName = try container.decode(String.self, forKey: .fName)
        let lname = try container.decode(String.self, forKey: .lName)
        self.fullName = fName + " " + lname
        self.status = try container.decode(String.self, forKey: .status)
        self.screenName = try container.decode(String.self, forKey: .screenName)
    }
}
