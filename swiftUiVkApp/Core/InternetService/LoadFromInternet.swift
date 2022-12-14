//
//  LoadFromInternet.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation
import Combine
import VKApiMethods

//MARK: - Класс загрузки данных из интернета по  Api методу!

final class LoadFromInternet: LoadServiceInterface {
    
    internal var verifyConnection: VerifyConnectionInterface = VeryfyConnectionToInternet()
    private(set) var subscriber: Set<AnyCancellable> = Set<AnyCancellable>()

    lazy var decoder = JSONDecoder()

    /*
     При вызове load необходимо передать тип модели данных (Friends.self, UserGroupModel.self ....)
     пример: load(for: Friends.self, apiMethod: .getAllFriends(token: token, userId: userId))
     обработать:    .sink
                    .store
     */
    
    func load<T: Decodable>(for objectType: T.Type, apiMethod: VKApiMethods) async -> Future<T, ServiceError> {
        let userId = apiMethod.associatedType()
        self.decoder.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(userId)!]
        return Future<T, ServiceError> { [unowned self] promise in
            
            guard let url = apiMethod.absoluteURL else {
                return promise( .failure(.invalidURL))
            }
            guard self.verifyConnection.isConnected() else {
                return promise( .failure(.internetConnectionFault))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data , response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw ServiceError.responseError
                    }
                       return data
                }
                .decode(type: T.self, decoder: self.decoder)
                .receive(on: RunLoop.main)
                .sink { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                  
                        default:
                            promise(.failure(.jenericError))
                        }
                    }
                } receiveValue: {
                    promise(.success($0.self))
                }
                .store(in: &self.subscriber)

        }
    }
}
