//
//  InternetValidator.swift
//  InternetValidator_Thorsignia
//
//  Created by Rajesh Gandru on 3/22/21.
//  All rights reseved to Thorsignia
//
import Foundation

public class R_InternetClassValidator {

    init(){
         NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
    }


    public static func InternetChecking()-> Bool{
         return updateUserInterface()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
  

    static func updateUserInterface()-> Bool {
        do {
            let host = try R_Reachability(hostname: "www.google.com")
            print("Reachability Summary")
            print("Status:", R_Reachability.status)
            print("HostName:", host?.hostname ?? "nil")
            print("Reachable:", R_Reachability.isReachable)
            print("Wifi:", R_Reachability.isReachableViaWiFi)
            
            switch R_Reachability.status {
            case .unreachable:
                 return false
            case .wwan:
                print("Internet connected with mobile")
                return true
            case .wifi:
                print("Internet connected with WIFI")
                 return true
            }
         }catch {
             return false
        }
     }
    @objc func statusManager(_ notification: Notification) {
      }

}



