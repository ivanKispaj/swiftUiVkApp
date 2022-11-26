//
//  InternetService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit
import RealmSwift
import Network


// MARK: - Класс для доступа в интернет по умолчанию протокол(схема) hhtps, host и path надо передавать при создании соединения
final class InternetService: InternetLoadDataInterface {
    
    var verifyConnection: VerifyConnectionInterface = VeryfyConnectionToInternet()
        
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    private(set) var urlComponents: URLComponents
    let baseUrl = "api.vk.com"
    private(set) var scheme = "https"
    
    //MARK: - init
    init (path: ApiPath) {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = self.scheme
        self.urlComponents.host = self.baseUrl
        self.urlComponents.path = path.rawValue
    }
    
    func sendQuery(from query: [URLQueryItem], completion: @escaping( Data?, Error? ) -> Void) {
        self.urlComponents.queryItems = query
        guard let url = self.urlComponents.url else { return }
        self.session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil,error)
            }
            guard let data = data else {
                return
            }
            completion(data,nil)
        }.resume()
    }
}




