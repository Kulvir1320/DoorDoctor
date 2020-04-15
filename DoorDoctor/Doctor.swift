//
//  Doctor.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-14.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation
class Doctor{
    
    init(id: Int, name: String, specialist: String, phone: Int, email: String){
        self.id = id
        self.name = name
        self.specialist = specialist
        self.phone = phone
        self.email = email
    }
    
    var id: Int
    var name: String
    var specialist: String
    var phone: Int
    var email: String

    static var doctor = [Doctor]()
}
