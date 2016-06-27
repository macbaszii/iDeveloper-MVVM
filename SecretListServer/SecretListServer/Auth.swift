//
//  Auth.swift
//  SecretListServer
//
//  Created by Kittinun Vantasin on 6/27/16.
//  Copyright © 2016 iOS Dev TH. All rights reserved.
//

import Foundation
import Swifter

private let validEmail = "bas@apple.com"
private let validPassword = "abcd1234"

var items = [
  Item(title: "Buy Milk", createdAt: NSDate()),
  Item(title: "Sing Karaoke", createdAt: NSDate()),
  Item(title: "Test drive", createdAt: NSDate()),
  Item(title: "Visit mom", createdAt: NSDate()),
  Item(title: "Bake a cake", createdAt: NSDate()),
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
        guard let title = params["title"] else { return .BadRequest(.Json(["error": "title can't be blank"])) }
        
        let newItem = Item(title: title, createdAt: NSDate())
        items.append(newItem)
        return .OK(.Json(newItem.toDict()))
    }
}

func auth(server: HttpServer) {
  server.post["/auth"] = { request in
    let fields = paramsObject(with: request)
    
    guard let email = fields["email"],
          let password = fields["password"]
        where email == validEmail && password == validPassword else { return .Unauthorized }
    
    let d = ["accessToken" : NSUUID().UUIDString]
    return .OK(.Json(d))
  }
}

func paramsObject(with request: HttpRequest) -> [String: String] {
    return request.parseUrlencodedForm().reduce([String: String]()) { map, item in
        var _map = map
        _map[item.0] = item.1
        return _map
    }
}
