//
//  Tweet.swift
//  tweetChamp
//
//  Created by Olivia Brown on 7/6/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import Foundation
import SwiftyJSON
import Parse

//Defines Tweet struct to gather information from the JSON tree
struct Tweet {
    let username: String // screen_name
    let fullName: String // name
    let userID: Int // id_str
    var retweetCount: Int // retweet_count
    let createdAt: String // created_at
    
//Defines JSON tree paths for each of the Tweet struct properties
    init(json: JSON) {
        self.username = json["user"]["screen_name"].stringValue
        self.fullName = json["user"]["name"].stringValue
        self.userID = json["user"]["id_str"].intValue
        self.retweetCount = json["retweet_count"].intValue
        self.createdAt = json["created_at"].stringValue
    }
}

//Defines User struct to gather information from the JSON tree
struct User {
    let username: String // screen_name
    let fullName: String // name
    let userID: Int // id_str
    let activeChallenges: [PFObject]
    let following: [Int]
    
//Filling in each user's profile
    init() {
        self.username = ""
        self.fullName = ""
        self.userID = 0
        self.activeChallenges = []
        self.following = []
    }

//Defines JSON tree paths for each of the User struct properties
    init(json: JSON) {
        self.username = json["user"]["screen_name"].stringValue
        self.fullName = json["user"]["name"].stringValue
        self.userID = json["user"]["id_str"].intValue
        self.activeChallenges = []
        self.following = [json["ids"].intValue]
        // self.totalRetweets = getRetweetTotal() !!
    }
}
