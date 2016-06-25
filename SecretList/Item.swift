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
    var createdAt: NSDate
    var completed: Bool
    
    init(title: String, createdAt: NSDate, completed: Bool) {
        self.title = title
        self.createdAt = createdAt
        self.completed = completed
    }
  
}
