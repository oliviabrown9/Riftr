//
//  CompTableViewCell.swift
//  tweetChamp
//
//  Created by Randy Perecman on 7/8/16.
//  Copyright © 2016 tweetChamp. All rights reserved.
//

import UIKit

// TableViewCell for each active competition
class CompTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
