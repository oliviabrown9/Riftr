//
//  Competition.swift
//  tweetChamp
//
//  Created by Olivia on 7/15/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import Parse
import Foundation

class Competition: PFObject, PFSubclassing {
    
    var challenger1: String = ""
    var challenger2: String = ""
    var retweetTotal1: Int = 0
    var retweetTotal2: Int = 0
    var winner: String = ""
    

}
   