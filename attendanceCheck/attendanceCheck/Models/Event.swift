//
//  Event.swift
//  RestApiTest
//
//  Created by Fanky on 24.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class Event {
    var date: NSDate?
    var desc: String?
    var eventType: EventType?
    
    init(date: NSDate, desc: String?, eventType: EventType?) {
        self.date = date
        self.desc = desc
        self.eventType = eventType
    }
    
    init(date: String?, desc: String?, eventType: EventType?) {
        if let tmpDate = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.date = dateFormatter.dateFromString(tmpDate)!
        }
        self.desc = desc
        self.eventType = eventType
    }
    
    init(eventData: [String: AnyObject]) {
        if let date = eventData["date"] as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.date = dateFormatter.dateFromString(date)!
        }
        if let desc = eventData["desc"] as? String {
            self.desc = desc
        }
        if let eventTypeData = eventData["event_type"] as? [String: AnyObject] {
            let eventType = EventType(eventTypeData: eventTypeData)
            self.eventType = eventType
        }
    }
}