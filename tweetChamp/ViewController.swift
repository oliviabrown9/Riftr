//
//  ViewController.swift
//  tweetChamp
//
//  Created by Olivia Brown on 7/6/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON
import Parse

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                
                let defaults = UserDefaults.standard
                defaults.set(unwrappedSession.userName, forKey: "userTwitterName")
                
                self.performSegue(withIdentifier: "toMain", sender: self)

            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // Formatting Twitter login button
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    func makeAUser(_ twitterUserName: String) {
        // Defining Parse user
        let newUser = PFUser()
        
        // Inputs information on logged in user to Parse server
        newUser.username = twitterUserName
        newUser.password = "test"
        newUser.email = "me@gmail.com"
        
        // Sign up the user asynchronously
        newUser.signUpInBackground(block: { (succeed, error) -> Void in

            if ((error) != nil) {
                print("success no error with PFUser sign up")
            } else {
                print("there was an error with PFUser sign up")
            }
        })
    }
}

