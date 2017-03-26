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
        
        /*
        //gradient
        let color1 = UIColor(red: 42.0/255.0, green: 163.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 88.0/255.0, green: 178.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        let color3 = UIColor(red: 141.0/255.0, green: 192.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        let color4 = UIColor(red: 224.0/255.0, green: 226.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        
        let gradientColor: [CGColor] = [color1.cgColor,color2.cgColor,color3.cgColor,color4.cgColor]
        let gradientLocations: [Float] = [0.0, 0.25, 0.75, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
 */       
 
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
            
            self.buttonContainerView.alpha = 1
            self.titleLabel.alpha = 1
            
            self.buttonContainerView.frame = self.buttonContainerView.frame.offsetBy(dx: 0, dy: -20)
            self.titleLabel.frame  = self.titleLabel.frame.offsetBy(dx: 0, dy: -20)
            
            
        }
        
    }
    
    @IBAction func loginButton() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
