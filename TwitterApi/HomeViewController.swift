//
//  HomeViewController.swift
//  TwitterApi
//
//  Created by dima on 27/03/2017.
//  Copyright © 2017 dima. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logout() {
        TwitterClient.sharedInstance?.logout()
    }

}
