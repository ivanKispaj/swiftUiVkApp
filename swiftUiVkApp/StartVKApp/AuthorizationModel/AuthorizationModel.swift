//
//  AuthorizationModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 19.11.2022.
//

import Foundation
import SwiftUI
import LocalAuthentication

enum BiometricType: String {
   case none  = "Введите код"
   case touchID = "TouchID"
   case faceID = "FaceID"
}

final class AuthorizationModel: ObservableObject {

    @Published private(set) var token: String = ""
    @Published private(set) var userId: String = ""
    @Published private(set) var isbiometricAuthorization: Bool = false
    @Published private(set) var code: String = ""
    @Published var isUnlocked: Bool = false
    var isFailedUnlock = false
    
    var biometricType: BiometricType {
           var error: NSError?
        let context = LAContext()
           guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
               // Capture these recoverable error through fabric
               return .none
           }

           if #available(iOS 11.0, *) {
               switch context.biometryType {
               case .touchID:
                   return .touchID
               case .faceID:
                   return .faceID
               default:
                   return .none
               }
           }

           return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
       }
    
    
    init() {
        self.getAuthData()
    }
    
    func getAuthData() {
        if let token = UserDefaults.standard.string(forKey: "token"),
           let userId = UserDefaults.standard.string(forKey: "userId"),
           let code = UserDefaults.standard.string(forKey: "authCode")
          
        {
            self.token = token
            self.userId = userId
            self.code = code
            UserDefaults.standard.set(true, forKey: "usedBiometrics")
            self.isbiometricAuthorization = UserDefaults.standard.bool(forKey: "usedBiometrics")
          
        }
    }
    
    func authenticate(_ completion: @escaping(Bool)-> ()) async {
       let context = LAContext()
       var error: NSError?
        
       // check whether biometric authentication is possible
       if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
           // it's possible, so go ahead and use it
           let reason = "We need to unlock your data."
           
           context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
               // authentication has now completed
               if success {
                   DispatchQueue.main.async {
                       self.isUnlocked = true

                   }

                   completion(true)
                 
                   // authenticated successfully
               } else {
                   DispatchQueue.main.async {
                       self.isUnlocked = false

                   }
                   completion(false)
                  
               }
           }
       } else {
       }
   }
    
}


extension String {

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

