//
//  AttendanceApi.swift
//  attendanceCheck
//
//  Created by Fanky on 22.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class AttendanceApi {
    
    static func getAttendances(completion: [Attendance] -> Void) {
        RestManager.performRequest("attendances/", method: "GET", body: nil) {
            (data, response, error) in
            let attendanceList = data as? [[String: AnyObject]]
            var attendances = [Attendance]()
            
            for attendance in attendanceList! {
                attendances.append(Attendance(attendanceData: attendance))
            }
            completion(attendances)
        }
    }
    
    static func getAttendancesForEvent(event: Event, completion: [Attendance] -> Void) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let eventDate = dateFormatter.stringFromDate(event.date!)
        
        RestManager.performRequest("attendances/" + eventDate + "/", method: "GET", body: nil) {
            (data, response, error) in
            let attendanceList = data as? [[String: AnyObject]]
            var attendances = [Attendance]()
            
            for attendance in attendanceList! {
                attendances.append(Attendance(attendanceData: attendance))
            }
            completion(attendances)
        }
    }
    
    static func updateAttendance(id: Int, body: Attendance, completion: () -> Void) {
        let json: [String: AnyObject]
        if let status = body.status {
            json = ["status": status]
        } else {
            json = ["status": NSNull()]
        }
        
        RestManager.performRequest("attendances/" + String(id) + "/", method: "PUT", body: json) {
            (data, response, error) in
            completion()
        }
    }
}