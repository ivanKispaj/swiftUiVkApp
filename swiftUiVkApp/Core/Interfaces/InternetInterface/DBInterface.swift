//
//  DBInterface.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 04.12.2022.
//

import Foundation
import RealmSwift
import Combine

protocol DBInterface: LoadServiceInterface {
    
    func updateData(object: Object)
    func deleteData(object: Object, cascading: Bool)
    func updateData(object: [Object])
    func saveData(object: Object)
    func printConfiguration()
}
