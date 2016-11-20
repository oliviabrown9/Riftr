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
    var myChallenges = [PFObject]()
    var twitterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let defaultsTwitterName = defaults.string(forKey: "userTwitterName") {
            twitterName = defaultsTwitterName
            print("twitter name: \(twitterName)")
        }
        getCurrentComps()
    }

    override func viewWillAppear(_ animated: Bool) {
        getCurrentComps()
    }

    func getCurrentComps() {
        var query = PFQuery(className: "Competition")

        let query1 = PFQuery(className: "Competition")
        query1.whereKey("Challenger1", equalTo: twitterName)
        let query2 = PFQuery(className: "Competition")
        query2.whereKey("Challenger2", equalTo: twitterName)
        
        query = PFQuery.orQuery(withSubqueries: [query1, query2])
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                print("Successfully retrieved: \(objects)")
                self.myChallenges = objects!
                self.challengesTableView.reloadData()
                print("Array of Objects \(self.myChallenges.count)")
            } else {
                print("Error: \(error)")
            }
        }

    }
    
    //Unwind segues
    @IBAction func unwindToContainerVC(_ segue: UIStoryboardSegue) {
    }
    @IBAction func unwindToChallenges(_ segue: UIStoryboardSegue) {
    }
    
    
    //All TableView Datasource functions
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        //Sets up the competition view depending on which cell is clicked !!
        let competitionObject = PFObject(className: "Competition")
        
        print(PFUser.current()?.username as Any)
    }
    
    //Only one section needed
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    //Sets number of rows to how many active challenges the current user has
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return .count of array of comeptitons relating to personal user
        return myChallenges.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompTableViewCell", for: indexPath) as! CompTableViewCell
        
        cell.usernameLabel?.text = (myChallenges[indexPath.row] as AnyObject).object(forKey: "Challenger2") as? String
        return cell
    }
}
