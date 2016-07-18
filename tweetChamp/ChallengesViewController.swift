//
//  ChallengesViewController.swift
//  tweetChamp
//
//  Created by Randy Perecman on 7/7/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit
import Parse

class ChallengesViewController: UIViewController {
    
    @IBOutlet weak var challengesTableView: UITableView!
    var myChallenges = []
    var twitterName = ""
    
    //Setting up the Parse Competition class
    //var myChallenges: [PFObject]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let defaultsTwitterName = defaults.stringForKey("userTwitterName") {
            twitterName = defaultsTwitterName
            print("twitter name: \(twitterName)")
        }
        
        getCurrentComps()
    }

    override func viewWillAppear(animated: Bool) {
        getCurrentComps()
    }

    func getCurrentComps() {
        var query = PFQuery(className: "Competition")
        
        /*
        let query1 = PFQuery(className: "Competition")
        query1.whereKey("Challenger1", equalTo: "randle_chase1")
        let query2 = PFQuery(className: "Competition")
        query2.whereKey("Challenger2", equalTo: "randle_chase1")
        */
        let query1 = PFQuery(className: "Competition")
        query1.whereKey("Challenger1", equalTo: twitterName)
        let query2 = PFQuery(className: "Competition")
        query2.whereKey("Challenger2", equalTo: twitterName)
        
        query = PFQuery.orQueryWithSubqueries([query1, query2])
        //query = PFQuery(className: "Competition")
        //query.whereKey("Challenger1", equalTo: "sundarpichai")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved: \(objects)")
                self.myChallenges = objects!
                self.challengesTableView.reloadData()
                print("Array of Objects \(self.myChallenges.count)")
            } else {
                print("Error: \(error) \(error!.userInfo)")
            }
        }

    }


/*
    func getCurrentComps() {
        let compsWithChallenger1 = Competition.query()
        compsWithChallenger1!.whereKey((PFUser.currentUser()?.username)!, equalTo: "Challenger1")
        let compsWithChallenger2 = Competition.query()
        compsWithChallenger2!.whereKey((PFUser.currentUser()?.username)!, equalTo: "Challenger2")

        let query = PFQuery.orQueryWithSubqueries([compsWithChallenger1!, compsWithChallenger2!])
        query.includeKey("username")
        query.orderByDescending("CreatedAt")
       query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        query.findObjectsInBackground()
    }
*/
 
    // !! Querying all competitions to find the ones the user is involved in (Doesn't really work probably)
//    func getCurrentComps() {
//        
//        let compsWithChallenger1 = Competition.query()
//        compsWithChallenger1!.whereKey((PFUser.currentUser()?.username)!, equalTo: "Challenger1")
//        let compsWithChallenger2 = Competition.query()
//        compsWithChallenger2!.whereKey((PFUser.currentUser()?.username)!, equalTo: "Challenger2")
//        
//        let query = PFQuery.orQueryWithSubqueries([compsWithChallenger1!, compsWithChallenger2!])
////        query.includeKey("username")
////        query.orderByDescending("CreatedAt")
////       query.skip = range.startIndex
////        query.limit = range.endIndex - range.startIndex
//        query.findObjectsInBackground()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Unwind segues
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
    }
    @IBAction func unwindToChallenges(segue: UIStoryboardSegue) {
    }
    
    /*
     // Another attempt at querying that also doesn't work !!
     
     func getCurrentChallenges(completionBlock: PFQueryArrayResultBlock) {
     var currentChallengeArray: [User] = []
     var query = PFQuery(className: "Competition")
     query.whereKey("Challenger1", equalTo: User().fullName)
     query.whereKey("Challenger2", equalTo: User().fullName)
     query.findObjectsInBackground()
     }
     
     */
    
    
    //All TableView Datasource functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //Sets up the competition view depending on which cell is clicked !!
        let competitionObject = PFObject(className: "Competition")
        
        print(PFUser.currentUser()?.username)
        
        /*
        competitionObject["Challenger1"] = PFUser.currentUser()?.username
        competitionObject["Challenger2"] = followerArray[indexPath.row].screenName
        let date = competitionObject["createdAt"]
        competitionObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        */
    }
    
    //Only one section needed
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //Sets number of rows to how many active challenges the current user has
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return .count of array of comeptitons relating to personal user
        return myChallenges.count
    }
    
    /*
    //Fills in information in cell for each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CompTableViewCell", forIndexPath: indexPath) as! CompTableViewCell
        cell.usernameLabel?.text = myChallenges![indexPath.row]
        
        func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            // timelineComponent.targetWillDisplayEntry(indexPath.row) !!
        }
        return cell
    }
    */
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CompTableViewCell", forIndexPath: indexPath) as! CompTableViewCell
        
        cell.usernameLabel?.text = myChallenges[indexPath.row] .objectForKey("Challenger2") as? String
        return cell
    }
}
