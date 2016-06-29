//
//  APIManager.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class APIManager
{
    private let session = URLSession(
        configuration: .default(),
        delegate: nil,
        delegateQueue: .main())
    
    static let sharedManager = APIManager()
    
    typealias AccessTokenCompletionBlock = (token: String?, error: NSError?) -> ()
    
    func login(with email: String, and password: String, completionBlock block: AccessTokenCompletionBlock)
    {
        let headers: [String: String] = [ .contentType: .applicationJSON ]
        
        let endpoint = (email == "bas@apple.com" && password == "abcd1234") ? "http://private-454f-mine8.apiary-mock.com/auth" : "http://private-454f-mine8.apiary-mock.com/auth/failed"
        
        if let url = URL(string: endpoint)
        {
            var request = URLRequest(url: url)
            request.httpMethod = .POST
            request.allHTTPHeaderFields = headers
            
            session
                .dataTask(with: request) { (data, response, error) in
                    let accessToken = data
                        .flatMap() { try? JSONSerialization.jsonObject(with: $0, options: []) }
                        .flatMap() { $0 as? [String: String] }
                        .flatMap() { $0[.accessToken] }
                    block(token: accessToken, error: error) }
                .resume()
        }
        else
        {
            fatalError("invalid endpoint: \(endpoint)")
        }
    }
}

private typealias HTTPMethodString = String
extension HTTPMethodString
{
    static var POST = "POST"
}

private typealias HTTPHeaderString = String
extension HTTPHeaderString
{
    static var contentType = "Content-Type"
    static var applicationJSON = "application/json"
}

private typealias JSONKey = String
extension HTTPHeaderString
{
    static var accessToken = "access_token"
}
