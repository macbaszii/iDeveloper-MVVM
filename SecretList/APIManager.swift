//
//  APIClient.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static let sharedManager = APIManager()

    typealias AccessTokenCompletionBlock = (token: String?, error: NSError?) -> ()
    func login(with email: String, and password: String, completionBlock block: AccessTokenCompletionBlock) {

        let params = ["email": email, "password": password]
        let headers = ["Content-Type": "application/json"]

        let endPoint = (email == "bas@apple.com" && password == "abcd1234") ? "http://private-454f-mine8.apiary-mock.com/auth" : "http://private-454f-mine8.apiary-mock.com/auth/failed"

        Alamofire.Manager.sharedInstance.request(.POST, endPoint, parameters: params, encoding: .URL, headers: headers)
          .validate()
          .responseJSON { (response: Response<AnyObject, NSError>) in
            switch response.result {
            case .Success(let json):
                if let json = json as? [String: AnyObject] {
                    block(token: json["access_token"] as? String, error: nil)
                }
            case .Failure(let error):
                block(token: nil, error: error)
            }
        }
    }
}
