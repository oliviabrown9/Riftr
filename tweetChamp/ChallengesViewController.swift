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
        
        let query1 = PFQuery(className: "Competition")
        query1.whereKey("Challenger1", equalTo: twitterName)
        let query2 = PFQuery(className: "Competition")
        query2.whereKey("Challenger2", equalTo: twitterName)
        
        query = PFQuery.orQueryWithSubqueries([query1, query2])
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Unwind segues
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
    }
    @IBAction func unwindToChallenges(segue: UIStoryboardSegue) {
    }
    
    //All TableView Datasource functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //Sets up the competition view depending on which cell is clicked !!
        let competitionObject = PFObject(className: "Competition")
        
        print(PFUser.currentUser()?.username)

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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CompTableViewCell", forIndexPath: indexPath) as! CompTableViewCell
        
        cell.usernameLabel?.text = myChallenges[indexPath.row] .objectForKey("Challenger2") as? String
        return cell
    }
}
