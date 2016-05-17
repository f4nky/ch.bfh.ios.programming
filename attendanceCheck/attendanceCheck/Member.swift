//
//  Member.swift
//  attendanceCheck
//
//  Created by Fanky on 03.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

struct Member {
    let id:Int
    let firstName:String
    let lastName:String
    let birthDate:NSDate?
    
    /*init(dictionary: [String: AnyObject]) {
        id = dictionary["id"] as? Int ?? -99
        firstName = dictionary["first_name"] as? String ?? ""
        lastName = dictionary["last_name"] as? String ?? ""
        birthDate = dictionary["birth_date"] as? NSDate ?? nil
    }*/
}