//
//  APIClient.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class APIManager {
    let session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    static let sharedManager = APIManager()
    
    typealias AccessTokenCompletionBlock = (token: String?, error: NSError?) -> ()
    func login(with email: String, and password: String, completionBlock block: AccessTokenCompletionBlock) {
        
        let headers = ["Content-Type": "application/json"]
        
        let endpoint = (email == "bas@apple.com" && password == "abcd1234") ? "http://private-454f-mine8.apiary-mock.com/auth" : "http://private-454f-mine8.apiary-mock.com/auth/failed"
        
        let request = NSMutableURLRequest(URL: NSURL(string: endpoint)!)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        session.dataTaskWithRequest(request) { (data, response, error) in
            guard let data = data,
                let JSONData = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: String],
                let accessToken = JSONData?["access_token"]
                else {
                    block(token: nil, error: error)
                    return
            }
            
            block(token: accessToken, error: nil)
            }.resume()
    }
}
