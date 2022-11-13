//
//  LoadGroups.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//


import UIKit
import RealmSwift

//MARK: - метод для запроса групп пользователя
extension InternetConnections {
    
    func loadGroups(to userId: String, acces token: String, completion: @escaping([ItemsGroup])->()) {
        
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity, city, description, links, site, status "),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        
        guard let url = self.urlComponents.url else { print("Url Error")
            return
        }
        
        self.session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Internet Error")
                return
                
                
            }
            do {
                let decode = JSONDecoder()
                let result = try decode.decode(UserGroupModel.self, from: data)
                completion(result.response.items)
                
            }catch {
                print("Parse error")
            }
        }.resume()
    }
}
