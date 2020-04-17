//
//  infoCustomCellTableViewCell.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class infoCustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
