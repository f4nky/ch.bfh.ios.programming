//
//  MemberTypeApi.swift
//  attendanceCheck
//
//  Created by Fanky on 24.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class MemberTypeApi {
    
    static func getMemberTypes(completion: [MemberType] -> Void) {
        RestManager.performRequest("member-types/", method: "GET", body: nil) {
            (data, response, error) in
            let memberTypeList = data as? [[String: AnyObject]]
            var memberTypes = [MemberType]()
            
            for memberType in memberTypeList! {
                memberTypes.append(MemberType(memberTypeData: memberType))
            }
            completion(memberTypes)
        }
    }
}