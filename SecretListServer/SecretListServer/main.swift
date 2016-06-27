//
//  main.swift
//  SecretListServer
//
//  Created by Kittinun Vantasin on 6/27/16.
//  Copyright © 2016 iOS Dev TH. All rights reserved.
//

import Foundation
import Swifter

do {
  let server = HttpServer()
  try server.start(8888)
  
  //hello
  server.get["/"] = { r in
    var list = "<h2>Hello SecretListServer in Swift</h2> Available services:<br><ul>"
    server.routes.forEach { service in
      if !service.isEmpty {
        list += "<li><a href=\"\(service)\">\(service)</a></li>"
      }
    }
    list += "</ul>"
    return .OK(.Html(list))
  }
  
  //api
  auth(server)
  
  NSRunLoop.mainRunLoop().run()
} catch {
  print("Server has an error: \(error)")
}
