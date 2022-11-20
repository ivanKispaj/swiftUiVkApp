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
    @Published private(set) var isBiometricAuthorization: Bool = false
    @Published private(set) var code: String = ""
    @Published var isUnlocked: Bool = false
    var isFailedUnlock = false
    
    var biometricType: BiometricType  = .none
    
    
    init() {
        self.updateAuthData()
    }
    
    func updateAuthData() {
        biometricType = getAuthType()
        
        self.token = UserDefaults.standard.string(forKey: "token") ?? ""
        self.userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        self.code = UserDefaults.standard.string(forKey: "authCode") ?? ""
        self.isBiometricAuthorization = UserDefaults.standard.bool(forKey: "usedBiometrics")

    }
    
    func authentificate(_ completion: @escaping(Bool)-> ()) async {
        let context = LAContext()
        var error: NSError?
     
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
           
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                if success {
                    DispatchQueue.main.async {
                        self.isUnlocked = true
                    }
                    
                    completion(true)
                
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
    
    private func getAuthType() -> BiometricType {
        var error: NSError?
        let context = LAContext()
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            if let errorCode = error?.code {
                self.getErrorDescription(errorCode: errorCode)
            }
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
    
    
    func getErrorDescription(errorCode: Int)  {
        let description: String
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            description = "Authentication was not successful, because user failed to provide valid credentials."
            
        case LAError.appCancel.rawValue:
            description = "Authentication was canceled by application (e.g. invalidate was called while authentication was in progress)."
            
        case LAError.invalidContext.rawValue:
            description = "LAContext passed to this call has been previously invalidated."
            
        case LAError.notInteractive.rawValue:
            description = "Authentication failed, because it would require showing UI which has been forbidden by using interactionNotAllowed property."
            
        case LAError.passcodeNotSet.rawValue:
            description = "Authentication could not start, because passcode is not set on the device."
            
        case LAError.systemCancel.rawValue:
            description = "Authentication was canceled by system (e.g. another application went to foreground)."
            
        case LAError.userCancel.rawValue:
            description = "Authentication was canceled by user (e.g. tapped Cancel button)."
            
        case LAError.userFallback.rawValue:
            description = "Authentication was canceled, because the user tapped the fallback button (Enter Password)."
            
        default:
            description = "Error code \(errorCode) not found"
        }
        print(description)
        
     }
    
    
}


extension String {
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}

