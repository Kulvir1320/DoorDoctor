//
//  BookingModal.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation


class BookingModal {
    var dName: String
    var uName: String
    var Email: String
    var Gender: String
    var Phone: Int
    var uDate: String
    var uTime: String
    
    
    init(dName: String, uName: String , Email: String, Gender: String,Phone: Int, uDate: String, uTime: String ) {
        self.dName = dName
        self.uName = uName
        self.Email = Email
        self.Gender = Gender
        self.Phone = Phone
        self.uDate = uDate
        self.uTime = uTime
    }
}
