//
//  RestManager.swift
//  attendanceCheck
//
//  Created by Fanky on 04.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import Foundation

class RestManager: NSURLSessionDataTask {
    
    static let apiBaseUrl: String = "http://46.101.106.41/api/v1/"
    
    func performRequest(urlPart: String, method: String, body: NSObject?, completionHandler: (AnyObject?, NSURLResponse?, NSError?) -> Void) {
        
        print(RestManager.apiBaseUrl + urlPart)
        
        let url = NSURL(string: RestManager.apiBaseUrl + urlPart)!
        let request = NSMutableURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) in
            let responseObject: AnyObject?
            if let tmpData = data {
                responseObject = try! NSJSONSerialization.JSONObjectWithData(tmpData, options: [])
            } else {
                responseObject = nil
            }
            completionHandler(responseObject, response, error)
        }
        task.resume()
    }
    
    func getMembers(completion: [Member] -> Void) {
        self.performRequest("members/", method: "GET", body: nil) {
            (responseObject, response, error) in
            let memberList = responseObject as? [[String: AnyObject]]
            var members = [Member]()
            for member in memberList! {
                members.append(Member(dictionary: member))
            }
            completion(members)
        }
    }

}