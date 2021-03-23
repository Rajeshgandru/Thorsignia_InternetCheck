//
//  Rechability.swift
//  InternetValidator_Thorsignia
//
//  Created by Rajesh Gandru on 3/22/21.
//  All rights reseved to Thorsignia
//

import Foundation
import SystemConfiguration

public class R_Reachability {
    var hostname = "https://www.google.com/"
    var isRunning = false
    static var isReachableOnWWAN: Bool = false
    static var reachability: SCNetworkReachability?
    static var reachabilityFlags = SCNetworkReachabilityFlags()
    let reachabilitySerialQueue = DispatchQueue(label: "ReachabilityQueue")
    public init?(hostname: String) throws {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, hostname) else {
            throw Network.Error.failedToCreateWith(hostname)
        }
        R_Reachability.reachability = reachability
        self.hostname = hostname
        R_Reachability.isReachableOnWWAN = true
        try start()
    }
    public init() throws {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            throw Network.Error.failedToInitializeWith(zeroAddress)
        }
        
        R_Reachability.reachability = reachability
        R_Reachability.isReachableOnWWAN = true
        
        try start()
    }
    let str_Flags: () = R_Reachability.flagsChanged()

    static var status: Network.Status {
        return  !R_Reachability.isConnectedToNetwork ? .unreachable :
            isReachableViaWiFi    ? .wifi :
            isRunningOnDevice     ? .wwan : .unreachable
    }
    
    static var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
        return true
        #else
        return true
        #endif
    }()
    deinit { stop() }
    //}
    //
    ////***
    //
    //extension R_Reachability {
    
     func start() throws {
        guard let reachability = R_Reachability.reachability, !isRunning else { return }
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = Unmanaged<R_Reachability>.passUnretained(self).toOpaque()
        guard SCNetworkReachabilitySetCallback(reachability, callout, &context) else { stop()
            throw Network.Error.failedToSetCallout
        }
        guard SCNetworkReachabilitySetDispatchQueue(reachability, reachabilitySerialQueue) else { stop()
            throw Network.Error.failedToSetDispatchQueue
        }
        reachabilitySerialQueue.async { R_Reachability.flagsChanged() }
        isRunning = true
    }
    
     func stop() {
        defer { isRunning = false }
        guard let reachability = R_Reachability.reachability else { return }
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        R_Reachability.reachability = nil
    }
    
    static var isConnectedToNetwork: Bool {
        return isReachable &&
            !isConnectionRequiredAndTransientConnection &&
            !(isRunningOnDevice && isWWAN && !isReachableOnWWAN)
    }
    
    static var isReachableViaWiFi: Bool {
        return isReachable && isRunningOnDevice && !isWWAN
    }
    
    /// Flags that indicate the reachability of a network node name or address, including whether a connection is required, and whether some user intervention might be required when establishing a connection.
    static var flags: SCNetworkReachabilityFlags? {
        guard let reachability = reachability else { return nil }
        var flags = SCNetworkReachabilityFlags()
        return withUnsafeMutablePointer(to: &flags) {
            SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0))
        } ? flags : nil
    }
    
    /// compares the current flags with the previous flags and if changed posts a flagsChanged notification
    static func flagsChanged() {
        guard let flags = R_Reachability.flags, flags != reachabilityFlags else { return }
        reachabilityFlags = flags
        NotificationCenter.default.post(name: .flagsChanged, object: self)
    }
    
    /// The specified node name or address can be reached via a transient connection, such as PPP.
    var transientConnection: Bool { return R_Reachability.flags?.contains(.transientConnection) == true }
    
    /// The specified node name or address can be reached using the current network configuration.
    static var isReachable: Bool { return R_Reachability.flags?.contains(.reachable) == true }
    
    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. If this flag is set, the kSCNetworkReachabilityFlagsConnectionOnTraffic flag, kSCNetworkReachabilityFlagsConnectionOnDemand flag, or kSCNetworkReachabilityFlagsIsWWAN flag is also typically set to indicate the type of connection required. If the user must manually make the connection, the kSCNetworkReachabilityFlagsInterventionRequired flag is also set.
    var connectionRequired: Bool { return R_Reachability.flags?.contains(.connectionRequired) == true }
    
    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. Any traffic directed to the specified name or address will initiate the connection.
    var connectionOnTraffic: Bool { return R_Reachability.flags?.contains(.connectionOnTraffic) == true }
    
    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established.
    var interventionRequired: Bool { return R_Reachability.flags?.contains(.interventionRequired) == true }
    
    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. The connection will be established "On Demand" by the CFSocketStream programming interface (see CFStream Socket Additions for information on this). Other functions will not establish the connection.
    var connectionOnDemand: Bool { return R_Reachability.flags?.contains(.connectionOnDemand) == true }
    
    /// The specified node name or address is one that is associated with a network interface on the current system.
    var isLocalAddress: Bool { return R_Reachability.flags?.contains(.isLocalAddress) == true }
    
    /// Network traffic to the specified node name or address will not go through a gateway, but is routed directly to one of the interfaces in the system.
    var isDirect: Bool { return R_Reachability.flags?.contains(.isDirect) == true }
    
    /// The specified node name or address can be reached via a cellular connection, such as EDGE or GPRS.
    static var isWWAN: Bool { return R_Reachability.flags?.contains(.isWWAN) == true }
    
    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. If this flag is set
    /// The specified node name or address can be reached via a transient connection, such as PPP.
    static var isConnectionRequiredAndTransientConnection: Bool {
        return (R_Reachability.flags?.intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]) == true
    }
}

//***

func callout(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
    guard let info = info else { return }
    
    DispatchQueue.main.async {
//        R_Reachability
//            .flagsChanged()
        
        Unmanaged<R_Reachability>
            .fromOpaque(info)
            .takeUnretainedValue()
            .str_Flags
    }
//    DispatchQueue.main.async {
//        Unmanaged<R_Reachability>
//            .fromOpaque(info)
//            .takeUnretainedValue()
//            .flagsChanged()
//    }
}

//***

extension Notification.Name {
    static let flagsChanged = Notification.Name("FlagsChanged")
}

//***

public struct Network {
    static var reachability: R_Reachability!
    enum Status: String {
        case unreachable, wwan, wifi
        
    }
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
