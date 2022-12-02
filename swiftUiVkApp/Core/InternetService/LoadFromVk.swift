//
//  LoadFromVk.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation


//MARK: - Jeneric method for load data from VK
final class loadDataFromVk<T: Decodable>: LoadServiceInterface {
    
    var verifyConnection: VerifyConnectionInterface = VeryfyConnectionToInternet()
    
    func load(userId: String, apiMethod: ApiMethods) async -> T? {
        guard verifyConnection.isConnected(), let url = apiMethod.absoluteURL else { return nil }
        do {
            let decoder = JSONDecoder()
            decoder.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(userId)!]
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try decoder.decode(T.self, from: data)
            return result
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
