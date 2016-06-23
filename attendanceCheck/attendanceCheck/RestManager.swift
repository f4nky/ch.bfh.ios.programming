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
    
    static func performRequest(urlPart: String, method: String, body: AnyObject?, completionHandler: (AnyObject?, NSURLResponse?, NSError?) -> Void) {
        
        print(RestManager.apiBaseUrl + urlPart)
        
        let url = NSURL(string: RestManager.apiBaseUrl + urlPart)!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let HTTPBody = body {
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(HTTPBody, options: .PrettyPrinted)
        }
        
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

}