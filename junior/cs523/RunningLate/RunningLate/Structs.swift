//
//  People.swift
//  RunningLate
//
//  Created by Chris Rudel on 4/28/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  CS 523
//  Professor Damopolous
//  Running Late - Main.swift
//  I pledge my honor that I have abided by the Stevens Honor System - Christopher Rudel

import Foundation


struct Person: Encodable, Decodable{
    var name: String
    var phoneNumber: String
    var selected: Bool
}

struct Weekday: Encodable, Decodable{
    var day: String
    var enabled: Bool
}
