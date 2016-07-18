//
//  User-Object.swift
//  tweetChamp
//
//  Created by Randy Perecman on 7/7/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit

//Defines the user objects for each user
struct UserObject1
{
    var screenName: String!
    var fullName: String!
    var userId: Int!
    
    //Sets up the JSON tree path for each property
    init(dict: Dictionary<String, AnyObject>)
    {
        self.screenName = String(dict["screen_name"]!) //force unwrapping, maybe do this more elegantly
        self.fullName = String(dict["name"]!) //force unwrapping, maybe do this more elegantly
        self.userId = Int(String(dict["id_str"]!)) //force unwrapping, maybe do this more elegantly
    }
}
