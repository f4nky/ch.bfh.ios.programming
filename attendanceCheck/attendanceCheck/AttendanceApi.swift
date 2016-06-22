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
}