//
//  customTableViewCell.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-14.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    
    @IBOutlet var doctorImg: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var specialistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
