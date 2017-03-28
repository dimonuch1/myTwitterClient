//
//  User.swift
//  TwitterApi
//
//  Created by dima on 27/03/2017.
//  Copyright © 2017 dima. All rights reserved.
//

import UIKit

class User {
    
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser:User?
    
    class var currentUser: User? {
        get {
            //eсли пользователя нет
            if (_currentUser == nil) {
                //read user from userDefaults
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "user") as? Data
                do {
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
                } catch let error as NSError {
                    print(error)
                }
            }
            return _currentUser
        }
        
        set(user) {
            //save in userDefaults
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "user")
            } else {
                let a:Bool? = nil
                defaults.set(a, forKey: "user")
            }
        }
    }
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
    }
    
    
    
    
}
