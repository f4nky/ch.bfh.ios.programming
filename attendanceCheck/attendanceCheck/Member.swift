//
//  Member.swift
//  attendanceCheck
//
//  Created by Fanky on 25.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class Member {
    var firstName: String?
    var lastName: String?
    var birthDate: NSDate?
    
    init(firstName: String?, lastName: String?, birthDate: NSDate?) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
    
    init(memberData: [String: AnyObject]) {
        if let firstName = memberData["first_name"] as? String {
            self.firstName = firstName
        }
        if let lastName = memberData["last_name"] as? String {
            self.lastName = lastName
        }
        if let birthDate = memberData["birth_Date"] as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.birthDate = dateFormatter.dateFromString(birthDate)!
        }
    }
}