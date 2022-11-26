//
//  VKLoadInterface.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 26.11.2022.
//

import Foundation

protocol VKLoadInterface {
    associatedtype T
    func load(to userId: String, query: [URLQueryItem], completion: @escaping( T?, Error?) -> Void)
}
