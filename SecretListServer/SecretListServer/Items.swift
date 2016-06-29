//
//  Items.swift
//  SecretListServer
//
//  Created by Kiattisak Anoochitarom on 6/28/2559 BE.
//  Copyright © 2559 iOS Dev TH. All rights reserved.
//

import Foundation
import Swifter

var items = [
    Item(title: "Buy Milk", createdAt: NSDate(), completed: true),
    Item(title: "Sing Karaoke", createdAt: NSDate(), completed: false),
    Item(title: "Test drive", createdAt: NSDate(), completed: false),
    Item(title: "Visit mom", createdAt: NSDate(), completed: true),
    Item(title: "Bake a cake", createdAt: NSDate(), completed: false),
]

func allItems(server: HttpServer) {
    server.get["/items"] = { request in
        let json = ["items": items.map { item in item.toDict() }]
        return .OK(.Json(json))
    }
}

func addItem(server: HttpServer) {
    server.post["/items"] = { request in
        let params = paramsObject(with: request)
        guard let title = params["title"] else { return .BadRequest(.Json(error(with: "Title can't be blank"))) }
        
        let newItem = Item(title: title, createdAt: NSDate(), completed: false)
        items.append(newItem)
        return .OK(.Json(newItem.toDict()))
    }
}
