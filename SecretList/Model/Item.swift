//
//  Item.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class Item
{
    var title: String
    var createdAt: Date
    
    init(title: String, createdAt: Date)
    {
        self.title = title
        self.createdAt = createdAt
    }
}
