//
//  ApiPath.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.11.2022.
//

import Foundation

//MARK: - url Path
enum ApiPath: String {
    case getNews = "/method/newsfeed.get"
    case getVideo = "/method/video.get"
    case getFriends = "/method/friends.get"
    case getAllPhoto = "/method/photos.getAll"
    case getWall = "/method/wall.get"
    case getGroups = "/method/groups.get"
    case leaveGroup = "/method/groups.leave"
    case searchGroup = "/method/groups.search"
    case joinGroups = "/method/groups.join"
}
