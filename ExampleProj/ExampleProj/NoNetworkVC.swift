//
//  NoNetworkVCViewController.swift
//  DemoPodApp
//
//  Created by admin on 3/25/21.
//

import UIKit
import Thorsignia_InternetCheck

class NoNetworkVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Initialising moniter...
        NetStatus.startMonitoring()

    }

    @IBAction func tryAgainbtnref(_ sender: Any) {
        if NetStatus.isConnected {
            self.dismiss(animated: true, completion: nil)
         }
    }
    
}
