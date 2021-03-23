//
//  Validator.swift
//  InternetValidator_Thorsignia
//
//  Created by Rajesh Gandru on 3/22/21.
//  All rights reseved to Thorsignia
//

import Foundation
public func NetWorkRecallMethod(){
    do {
        try Network.reachability = R_Reachability(hostname: "www.google.com")
    }
    catch {
        switch error as? Network.Error {
        case let .failedToCreateWith(hostname)?:
            print("Network error:\nFailed to create reachability object With host named:", hostname)
        case let .failedToInitializeWith(address)?:
            print("Network error:\nFailed to initialize reachability object With address:", address)
        case .failedToSetCallout?:
            print("Network error:\nFailed to set callout")
        case .failedToSetDispatchQueue?:
            print("Network error:\nFailed to set DispatchQueue")
        case .none:
            print(error)
        }
    }
}
