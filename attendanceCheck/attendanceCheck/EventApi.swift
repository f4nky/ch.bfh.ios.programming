//
//  EventApi.swift
//  RestApiTest
//
//  Created by Fanky on 24.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class EventApi {
    
    static func getEvents(completion: [Event] -> Void) {
        RestManager.performRequest("events/", method: "GET", body: nil) {
            (data, response, error) in
            let eventList = data as? [[String: AnyObject]]
            var events = [Event]()
            
            for event in eventList! {
                events.append(Event(eventData: event))
            }
            completion(events)
        }
    }
}