//
//  Member.swift
//  attendanceCheck
//
//  Created by Fanky on 25.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class Member {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var birthDate: NSDate?
    var memberType: MemberType?
    
    init(id: Int?, firstName: String?, lastName: String?, birthDate: NSDate?, memberType: MemberType?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.memberType = memberType
    }
    
    init(memberData: [String: AnyObject]) {
        if let id = memberData["id"] as? Int {
            self.id = id
        }
        if let firstName = memberData["first_name"] as? String {
            self.firstName = firstName
        }
        if let lastName = memberData["last_name"] as? String {
            self.lastName = lastName
        }
        if let birthDate = memberData["birth_date"] as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.birthDate = dateFormatter.dateFromString(birthDate)!
        }
        if let memberTypeData = memberData["member_type"] as? [String: AnyObject] {
            let memberType = MemberType(memberTypeData: memberTypeData)
            self.memberType = memberType
        }
    }
}