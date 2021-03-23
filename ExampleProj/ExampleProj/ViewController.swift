//
//  ViewController.swift
//  ExampleProj
//
//  Created by admin on 3/23/21.
//

import UIKit
import Thorsignia_InternetCheck
class ViewController: UIViewController {

    //calling method in viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        //intialising internet checking...
        self.CheckingInterNet()
     }
     
     //Internet check main method...
    func CheckingInterNet(){
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    //With timer support handling internet handling...
    @objc func updateCounting(){
        NSLog("counting..")
         if  R_InternetClassValidator.InternetChecking() {
            print(" 👊👊👊👊👊👊 your internet is working fine...👊👊👊👊👊")
           // self.showAlert(msg : " Dam your internet is working fine bro...")
        }else {
            print(" 👊👊👊👊👊your internet have some issue, please check...👊👊👊👊")
            //self.showAlert(msg : " Dam your internet have some issue, please check bro...")

        }
    }
}

