//
//  userAccount.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation
//init(id: Int, name: String, specialist: String, phone: Int, email: String){
//    self.id = id
//    self.name = name
//    self.specialist = specialist
//    self.phone = phone
//    self.email = email
//}
//
//var id: Int
//var name: String
//var specialist: String
//var phone: Int
//var email: String
//
//static var doctor = [Doctor]()
class userAccount{
    var username: String
    var password: String
    var firstname: String
    var lastname: String
    var phone: Int
    var Email: String
    init(username: String, password: String,firstname: String, lastname: String, phone: Int,Email: String )
    {
        self.username = username
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
        self.phone = phone
        self.Email = Email
    }
    
    static var loggedInUser = ""
}
