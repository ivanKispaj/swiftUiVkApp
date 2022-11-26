//
//  LoadFromVk.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation



final class LoadFromVk<T: Decodable>: VKLoadInterface {
    
    let token: String
    let count: String
    let service: InternetLoadDataInterface
    
    //MARK: - init
    init(token: String, path: ApiPath, count: String = "20") {
        self.token = token
        self.count = count
        self.service = InternetService(path: path)
    }
    
    //MARK: - Load data from VKApi
    func load(to userId: String, query: [URLQueryItem], completion: @escaping (T?, Error?) -> Void) {
        guard service.verifyConnection.isConnected() else {
            completion(nil, ServiceError.internetConnectionFault)
            return
        }
        
        service.sendQuery(from: query) { data, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                // передаем пользователя для связи списка друзей с ним один ко многим!
                decoder.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(userId)!]
                let result = try decoder.decode(T.self, from: data)
                completion(result , nil)
            }catch {
                completion(nil, ServiceError.internetConnectionFault)
                print("Internet Error: \(error)")
            }
        }
        
    }
}
