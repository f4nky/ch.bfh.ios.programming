//
//  Attendance.swift
//  attendanceCheck
//
//  Created by Fanky on 22.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class Attendance {
    var id: Int?
    var status: String?
    var event: Event?
    var member: Member?
    
    init(id: Int?, status: String?, event: Event?, member: Member?) {
        self.id = id
        self.status = status
        self.event = event
        self.member = member
    }
    
    init(attendanceData: [String: AnyObject]) {
        if let id = attendanceData["id"] as? Int {
            self.id = id
        }
        if let status = attendanceData["status"] as? String {
            self.status = status
        }
        if let eventData = attendanceData["event"] as? [String: AnyObject] {
            let event = Event(eventData: eventData)
            self.event = event
        }
        if let memberData = attendanceData["member"] as? [String: AnyObject] {
            let member = Member(memberData: memberData)
            self.member = member
        }
    }
}