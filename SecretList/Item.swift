//
//  Item.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class Item {
    var title: String
    var createdAt: NSDate?
    
    init(title: String, createdAt: NSDate?) {
        self.title = title
        self.createdAt = createdAt
    }
    
    convenience init(json: [String: AnyObject]) {
        self.init(title: "", createdAt: nil)
        
        title = json["title"] as! String
        
        if let createdAt = date(from: json["created_at"] as! String) {
            self.createdAt = createdAt
        } else {
            createdAt = nil
        }
    }
    
    private func date(from ISOString: String) -> NSDate? {
        struct Instance {
            static let formatter = NSDateFormatter()
        }
        
        Instance.formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        Instance.formatter.timeZone = NSTimeZone(abbreviation: "GMT")
        Instance.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return Instance.formatter.dateFromString(ISOString)
    }
}