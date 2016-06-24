//
//  MemberApi.swift
//  attendanceCheck
//
//  Created by Fanky on 21.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class MemberApi {
    
    static func getMembers(completion: [Member] -> Void) {
        RestManager.performRequest("members/", method: "GET", body: nil) {
            (data, response, error) in
            let memberList = data as? [[String: AnyObject]]
            var members = [Member]()
            
            for member in memberList! {
                members.append(Member(memberData: member))
            }
            completion(members)
        }
    }
    
    static func saveMember(member: Member, completion: () -> Void) {
        RestManager.performRequest("members/", method: "POST", body: member) {
            (data, response, error) in
            completion()
        }
    }
}