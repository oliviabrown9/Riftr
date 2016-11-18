//
//  ViewController.swift
//  tweetChamp
//
//  Created by Randy Perecman on 7/6/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON
import Parse

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Setting up login with Twitter's Fabric
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                
                /*
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                */
 
                //self.makeAUser(unwrappedSession.userName)
                
                let defaults = UserDefaults.standard
                defaults.set(unwrappedSession.userName, forKey: "userTwitterName")
                
                //Now logged in, begin using app
                
                //bug fix
                /*
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in
                    self.performSegueWithIdentifier("toMain", sender: self)
                }))
                */
                self.performSegue(withIdentifier: "toMain", sender: self)
                //end
                
                //self.presentViewController(alert, animated: true, completion: nil)
                
                //Error with login handling
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        //Formatting Twitter login button
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
    }
    
    func makeAUser(_ twitterUserName: String) {
        
        //Some random stuff that Cliff put in that doesn't do anything
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        //Defining Parse user
        let newUser = PFUser()
        
        //Inputs information on logged in user to Parse server
        newUser.username = twitterUserName
        newUser.password = "test"
        newUser.email = "me@gmail.com"
        
        // Sign up the user asynchronously
        newUser.signUpInBackground(block: { (succeed, error) -> Void in
            
            // Stop the spinner more of Cliff's stuff
            spinner.stopAnimating()
            if ((error) != nil) {
                print("success no error with PFUser sign up")
            } else {
                print("there was an error with PFUser sign up")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

