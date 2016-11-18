//
//  TestViewController.swift
//  tweetChamp
//
//  Created by Randy Perecman on 7/6/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit
import Parse
import SwiftyJSON

//Create an empty array of each user's Tweets which will be filled in below
var userTweets: [Tweet] = []
var myUser = PFObject(className: "User")
class TestViewController: UIViewController {
    
    //Test label
    @IBOutlet weak var retweetTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the current user's User struct
        
        myUser["username"] = User().username
        myUser["userID"] = User().userID
        myUser["ActiveChallenges"] = User().activeChallenges
        
        //Accesses Fabric API to gather information of current user's tweets
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=200&include_rts=false"
            let params = ["user_id": userID]
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }
                
                //Access JSON tree
                do {
                    let tweetDataArray = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                    
                    for i in tweetDataArray {
                        let json = JSON(i)
                        let tweet = Tweet(json: json)
                        userTweets.append(tweet)
                    }
                    
                    //Method to add together all retweets from the current user !! Alter it to only include tweets from the past week
                    func getRetweetTotal() -> Int
                    {
                        var totalRetweets: Int = 0
                        
                        for x in userTweets {
                            let retweetsPer = x.retweetCount
                            totalRetweets += retweetsPer
                        }
                        return totalRetweets
                    }
                    
                    //Twitter Fabric error handling on the JSON tree
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                  }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

