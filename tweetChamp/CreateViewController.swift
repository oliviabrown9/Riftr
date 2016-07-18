//
//  CreateViewController.swift
//  tweetChamp
//
//  Created by Randy Perecman on 7/7/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit
import TwitterKit
import Fabric
import Parse

//Defines an empty array of the current user's followers which is filled in below

var followerArray: [UserObject1] = []
var twitterName = ""


//Stores value for the click on cell !!
var selectedIndexPath: NSIndexPath!

class CreateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    //TableView of all followers
    @IBOutlet weak var createTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        if let defaultsTwitterName = defaults.stringForKey("userTwitterName") {
            twitterName = defaultsTwitterName
            print("twitter name: \(twitterName)")
        }
        
        //Calls Fabric API that stores the people a user is following
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {

            let client = TWTRAPIClient(userID: userID)
            
            print(userID)
            
            // Do any additional setup after loading the view.
            let showFollowers = "https://api.twitter.com/1.1/friends/list.json?skip_status=true&count=50"
            let params = ["user_id": userID]
            var clientError : NSError?
            
            let request = client.URLRequestWithMethod("GET", URL: showFollowers, parameters: params, error: &clientError)
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }
                //Access JSON tree
                
                do {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    print("json \(dict)")
                    if let myArray = dict["users"]{
                        
                        var array: [Dictionary<String, AnyObject>] = []
                        array = myArray as! [Dictionary<String, AnyObject>]
                        
                        //Filling in follower array with followers
                        for data in 0..<array.count {
                            let user = UserObject1(dict: array[data])
                            followerArray.append(user)
                        }
                    } else {
                        print("I'm sad, no followers")
                    }
                
            self.createTableView.reloadData()
                    
                //Twitter handling JSON errors
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
        }
    }
            override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
        }
//    //When button is tapped, create a new instance of competition in Parse. Currently, creates instance when cell is tapped. !!
//    @IBAction func challengeTapped(sender: UIButton)
//    {
//        sender.enabled = false
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView Datasource functions
    //Handles when a cell is tapped to create a new instance of competition
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let competitionObject = PFObject(className: "Competition")

        //competitionObject["Challenger1"] = PFUser.currentUser()?.username
        //competitionObject["Challenger1"] = PFUser.currentUser()?.username
        competitionObject["Challenger1"] = twitterName
        
        competitionObject["Challenger2"] = followerArray[indexPath.row].screenName
        let date = competitionObject["createdAt"]
        competitionObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
    //Only one section necessary
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //Create as many cells as followers
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerArray.count
    }
    //Fills in information in each cell for each follower
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowerTableViewCell", forIndexPath: indexPath) as! FollowerTableViewCell
               cell.label?.text = followerArray[indexPath.row].fullName
               cell.sublabel?.text = "@\(followerArray[indexPath.row].screenName)"
            return cell
    }
    
    //Setting up the next view after a cell is tapped !!
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    

}