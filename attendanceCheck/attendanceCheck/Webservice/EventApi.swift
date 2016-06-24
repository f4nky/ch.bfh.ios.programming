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
    
    static func saveEvent(event: Event, completion: () -> Void) {
        RestManager.performRequest("events/", method: "POST", body: event) {
            (data, response, error) in
            completion()
        }
    }
    
    static func deleteEvent(id: Int, completion: () -> Void) {
        RestManager.performRequest("events/" + String(id) + "/", method: "DELETE", body: nil) {
            (data, response, error) in
            completion()
        }
    }
}