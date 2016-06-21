//
//  MemberType.swift
//  attendanceCheck
//
//  Created by Fanky on 21.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class MemberType {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    init(memberTypeData: [String: AnyObject]) {
        if let name = memberTypeData["name"] as? String {
            self.name = name
        }
    }
}