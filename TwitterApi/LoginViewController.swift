//
//  LoginViewController.swift
//  TwitterApi
//
//  Created by dima on 25/03/2017.
//  Copyright © 2017 dima. All rights reserved.
//

import UIKit
import CoreGraphics

class LoginViewController: UIViewController {

    @IBOutlet weak var logoVerticalConstaint: NSLayoutConstraint!
    @IBOutlet weak var logoMovedToTopConstraint:NSLayoutConstraint!
    @IBOutlet weak var logoHeightOriginalConstaraint:NSLayoutConstraint!
    @IBOutlet weak var logoHeightSmallerConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var buttonContainerView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buttonContainerView.layer.cornerRadius = 5
        buttonContainerView.alpha = 0
        titleLabel.alpha = 0
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logoVerticalConstaint.isActive = false
        logoMovedToTopConstraint.isActive = true
        logoHeightSmallerConstraint.isActive = true
        logoHeightOriginalConstaraint.isActive = false
        
        UIView.animate(withDuration: 3) {
            //refresh our constraints
            self.view.layoutIfNeeded()
        }

        UIView.animate(withDuration: 4) {
            self.buttonContainerView.alpha = 1
            self.titleLabel.alpha = 1
            
            self.buttonContainerView.frame = self.buttonContainerView.frame.offsetBy(dx: 0, dy: -20)
            self.titleLabel.frame  = self.titleLabel.frame.offsetBy(dx: 0, dy: -20)
        }
        
    }
    
    @IBAction func loginButton() {
        TwitterClient.sharedInstance?.login(success: {
            print("Logged In")
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error) in
            print("error \(error)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
