//
//  getUserNews.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import UIKit
import RealmSwift

//MARK: - Получаем новости для пользователя
extension InternetConnections {
    func getUserNews(acces token: String, completion: @escaping () -> ()) {
        
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "filters", value: "post, photo, video"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = self.urlComponents.url else { return }
        
        self.session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Connection Error: \(error)")
            }
            guard let data = data else {
                return
            }
            do {
                let decode = JSONDecoder()
                let result = try decode.decode(NewsDataModel.self, from: data)
                DispatchQueue.global(qos: .utility).async {
                    self.realmService.updateData(result.response)
                    
                }
                
            }catch {
                print("ParseError")
            }
        }.resume()
    }
}
