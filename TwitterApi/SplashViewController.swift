//
//  SplashViewController.swift
//  TwitterApi
//
//  Created by dima on 25/03/2017.
//  Copyright © 2017 dima. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController,TwitterLoginDelegate {

    enum Segue:String {
        case login = "LoginSegue"
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!appDelegate.splashDelay) {
            appDelegate.delay(delay: 2.0,clouser: {
                self.continueLogin()
                
            })
        }
        
    }
    
    func goToLogin() {
        self.performSegue(withIdentifier: Segue.login.rawValue, sender: self)
    }
    
    func continueLogin() {
        appDelegate.splashDelay = false
        self.goToLogin()
    }
        
}
