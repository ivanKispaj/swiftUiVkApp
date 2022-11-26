//
//  VerifyConnectionInterface.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 24.11.2022.
//

import Foundation
import SystemConfiguration

protocol VerifyConnectionInterface {
    func isConnected() -> Bool
}


//MARK: - Verify internet connection. Return true if the connection is established

struct VeryfyConnectionToInternet: VerifyConnectionInterface {
    
    func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        //   print(isReachable && !needsConnection)
        return (isReachable && !needsConnection)
    }
}
