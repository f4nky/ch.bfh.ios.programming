//
//  EventTypeApi.swift
//  attendanceCheck
//
//  Created by Fanky on 23.06.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class EventTypeApi {
    
    static func getEventTypes(completion: [EventType] -> Void) {
        RestManager.performRequest("event-types/", method: "GET", body: nil) {
            (data, response, error) in
            let eventTypeList = data as? [[String: AnyObject]]
            var eventTypes = [EventType]()
            
            for eventType in eventTypeList! {
                eventTypes.append(EventType(eventTypeData: eventType))
            }
            completion(eventTypes)
        }
    }
}