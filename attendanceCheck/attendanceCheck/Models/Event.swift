//
//  Event.swift
//  RestApiTest
//
//  Created by Fanky on 24.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class Event {
    var id: Int?
    var date: NSDate?
    var description: String?
    var eventType: EventType?
    
    init(id: Int?, date: NSDate, description: String?, eventType: EventType?) {
        self.id = id
        self.date = date
        self.description = description
        self.eventType = eventType
    }
    
    init(id: Int?, date: String?, description: String?, eventType: EventType?) {
        self.id = id
        if let tmpDate = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.date = dateFormatter.dateFromString(tmpDate)!
        }
        self.description = description
        self.eventType = eventType
    }
    
    init(eventData: [String: AnyObject]) {
        if let id = eventData["id"] as? Int {
            self.id = id
        }
        if let date = eventData["date"] as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.date = dateFormatter.dateFromString(date)!
        }
        if let description = eventData["description"] as? String {
            self.description = description
        }
        if let eventTypeData = eventData["event_type"] as? [String: AnyObject] {
            let eventType = EventType(eventTypeData: eventTypeData)
            self.eventType = eventType
        }
    }
}