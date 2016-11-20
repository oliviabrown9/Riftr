//
//  CreateViewController.swift
//  tweetChamp
//
//  Created by Olivia Brown on 7/7/16.
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
var selectedIndexPath: IndexPath!

class CreateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    //TableView of all followers
    @IBOutlet weak var createTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        if let defaultsTwitterName = defaults.string(forKey: "userTwitterName") {
            twitterName = defaultsTwitterName
            print("twitter name: \(twitterName)")
        }
        
        //Calls Fabric API that stores the people a user is following
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {

            let client = TWTRAPIClient(userID: userID)
            
            print(userID)
            
            let showFollowers = "https://api.twitter.com/1.1/friends/list.json?skip_status=true&count=50"
            let params = ["user_id": userID]
            var clientError : NSError?
            
            let request = client.urlRequest(withMethod: "GET", url: showFollowers, parameters: params, error: &clientError)
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }
                //Access JSON tree
                
                do {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
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
            override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableView Datasource functions
    //Handles when a cell is tapped to create a new instance of competition
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let competitionObject = PFObject(className: "Competition")
        competitionObject["Challenger1"] = twitterName
        
        competitionObject["Challenger2"] = followerArray[indexPath.row].screenName
        let date = competitionObject["createdAt"]
        competitionObject.saveInBackground { (success, error) in
            print("Object has been saved.")
        }
    }
    //Only one section necessary
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Create as many cells as followers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerArray.count
    }
    //Fills in information in each cell for each follower
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell", for: indexPath) as! FollowerTableViewCell
               cell.label?.text = followerArray[indexPath.row].fullName
               cell.sublabel?.text = "@\(followerArray[indexPath.row].screenName)"
            return cell
    }
    
    //Setting up the next view after a cell is tapped !!
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    

}
