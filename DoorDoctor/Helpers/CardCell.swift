//
//  CardCell.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-17.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    
    @IBOutlet var pictureView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    func configure(picture: UIImage,title: String, description: String) {
        
        pictureView.image = picture
        titleLabel.text = title
        descriptionLabel.text = description
        
        cardView.layer.shadowColor = UIColor.green.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 2.0
        
        
        
    }
}
