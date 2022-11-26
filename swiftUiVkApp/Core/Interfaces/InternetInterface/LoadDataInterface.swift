//
//  InternetInterface.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 23.11.2022.
//

import Foundation

protocol InternetLoadDataInterface: AnyObject {
    var verifyConnection: VerifyConnectionInterface { get }
    func sendQuery(from query: [URLQueryItem], completion: @escaping(Data?,Error?) -> Void)
}







