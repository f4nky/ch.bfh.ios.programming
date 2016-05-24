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
    
    init(date: NSDate, desc: String?) {
        self.date = date
        self.desc = desc
    }
    
    init(date: String?, desc: String?) {
        if let tmpDate = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.date = dateFormatter.dateFromString(tmpDate)!
        }
        self.desc = desc
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
    }
}