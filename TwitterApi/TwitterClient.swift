//
//  TwitterClient.swift
//  TwitterApi
//
//  Created by dima on 27/03/2017.
//  Copyright © 2017 dima. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient:BDBOAuth1SessionManager {
    //OAuth = Fetch Request Token + Redirect to Auth + Fetch Access Token + Callback URL

    //singltone
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "dsYieOmJVIe3B8FoxvCsVExiU", consumerSecret: "UVtxlzIx5YiEFH6lF3t1QxUlYZfpkmhluzJUY0zprzDVohlv6g")
    
    //Fetch Request Token + Redirect to Auth
    //getting requst token to open up autj link in safari
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    weak var delegate:TwitterLoginDelegate?
    
    func login (success: @escaping ()->(),failure:@escaping (NSError)->()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterTest://oauth") as URL!, scope: nil, success: { (requestToken) in
            print("Got token")
            //print(requestToken)
            
            //created referencew
            let url: URL! = NSURL(string:"https://api.twitter.com/oauth/authenticate?oauth_token=" + (requestToken?.token)!) as URL!
            
            //open reference
            UIApplication.shared.open(url)
        }) { (error) in
            print("login Error: \(error?.localizedDescription)")
            //self.loginFailure?(error as! NSError)
        }
    }
    
    //Ftch Access Token
    // будм обрабатывать уже открывшийся редирект и попробуем получить access token
    //get acces token and save user
    func handleOpenURL(url: NSURL) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.splashDelay = true
        
        //step 3
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)!
        
        //geting access token
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            //проверяем учетные данные нашего пользователя
            self.currentAccount(success: { (user:User) in
                //Calling setter and saving our user
                User.currentUser = user
                
          
                self.loginSuccess?()
                self.delegate?.continueLogin()
            }, failure: { (error:NSError) in
                self.loginFailure?(error)
            })
            self.loginSuccess?()
        }) { (error) in
            print("handleOpenURL Error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        }
  
    }
    
    //проверка данных пользователя
    //Get the current account
    func currentAccount(success:@escaping (User)->(), failure:@escaping (NSError)->()) {
        //проверяем учетные записи
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            //создаем пользователя
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
        }) { (task, error) in
            print("error: \(error.localizedDescription)")
            failure(error as NSError)
        }
        
    }
    
    //logout
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
}
