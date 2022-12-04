//
//  LoadServiceInterface.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation
import Combine

//MARK: - protocol for load data
protocol LoadServiceInterface {
    
   // Проверка интернет соединения
    var verifyConnection: VerifyConnectionInterface { get }
    // подписчик
    var subscriber: Set<AnyCancellable> { get }
    // Метод для загрузки данных
    func load<T: Decodable >( for objectType: T.Type ,apiMethod: ApiMethods) async -> Future< T, ServiceError >
}

