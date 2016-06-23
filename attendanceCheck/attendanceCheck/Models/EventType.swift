//
//  EventType.swift
//  attendanceCheck
//
//  Created by Fanky on 22.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class EventType {
    var id: Int?
    var name: String?
    var abbr: String?
    
    init(id: Int?, name: String?, abbr: String?) {
        self.id = id
        self.name = name
        self.abbr = abbr
    }
    
    init(eventTypeData: [String: AnyObject]) {
        if let id = eventTypeData["id"] as? Int {
            self.id = id
        }
        if let name = eventTypeData["name"] as? String {
            self.name = name
        }
        if let abbr = eventTypeData["abbr"] as? String {
            self.abbr = abbr
        }
    }
}