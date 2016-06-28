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
      
        Alamofire.Manager.sharedInstance.request(.POST, "http://localhost:8888/auth", parameters: params, encoding: .URL)
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
    
    typealias ItemsCompletionBlock = (items: [Item], error: NSError?) -> ()
    func allItems(completionBlock block: ItemsCompletionBlock) {
        
        Alamofire.Manager.sharedInstance.request(.GET, "http://localhost:8888/items")
            .validate()
            .responseJSON { (response: Response<AnyObject, NSError>) in
            
                switch response.result {
                case .Success(let json):
                    if let json = json as? [String: AnyObject],
                    let itemsObject = json["items"] as? [[String: AnyObject]] {
                        var items = [Item]()
                        
                        for item in itemsObject {
                            items.append(Item(json: item))
                        }
                        
                        block(items: items, error: nil)
                    }
                case .Failure(let error):
                    block(items: [], error: error)
                }
        }
    }
    
    typealias ItemCompletionBlock = (item: Item?, error: NSError?) -> ()
    func add(item item: Item, completionBlock block: ItemCompletionBlock) {
        
        let params = ["title": item.title]
        Alamofire.Manager.sharedInstance.request(.POST, "http://localhost:8888/items", parameters: params, encoding: .URL)
            .validate()
            .responseJSON { (response: Response<AnyObject, NSError>) in
                
                switch response.result {
                case .Success(let json):
                    if let json = json as? [String: AnyObject] {
                        let item = Item(json: json)
                        block(item: item, error: nil)
                    }
                case .Failure(let error):
                    block(item: nil, error: error)
                }
        }
    }
}