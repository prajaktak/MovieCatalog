//
//  Rechability.swift
//  MovieCatalog
//
//  Created by Prajakta Kulkarni on 12/05/2019.
//  Copyright © 2019 Prajakta Kulkarni. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else { return false }
        
        var flags = SCNetworkReachabilityFlags()
        guard SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) else { return false }
        
        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }
    
}
