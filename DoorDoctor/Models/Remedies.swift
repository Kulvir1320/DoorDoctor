//
//  Remedies.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation

struct Remedies: Codable {
    let title: String
    let version: Double
    let href: String
    var results: [Result]
}

struct Result: Codable {
    let title: String
    let href: String
    let ingredients: String
    let thumbnail:String
}
