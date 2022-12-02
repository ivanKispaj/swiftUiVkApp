//
//  InternetInterface.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation

//MARK: - protocol for load data
protocol LoadServiceInterface {
    associatedtype T
    var verifyConnection: VerifyConnectionInterface {get}
    func load(userId: String, apiMethod: ApiMethods) async -> T?
}







