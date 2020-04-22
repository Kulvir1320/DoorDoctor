//
//  Designable Text Field.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-13.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

@IBDesignable
class Designable_Text_Field: UITextField {

    @IBInspectable var leftImage: UIImage?{
    didSet {
        
        
        updateView()
    }
    
    }
    
    func updateView(){
        
        if let image = leftImage {
            rightViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x:0, y: 0, width: 50, height: 50))
            imageView.image = image
            
            rightView = imageView
        } else{
            
            rightViewMode = .never
        }
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
