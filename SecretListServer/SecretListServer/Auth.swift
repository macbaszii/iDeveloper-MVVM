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