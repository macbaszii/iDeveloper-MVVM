//
//  APIHelper.swift
//  SecretListServer
//
//  Created by Kiattisak Anoochitarom on 6/28/2559 BE.
//  Copyright © 2559 iOS Dev TH. All rights reserved.
//

import Foundation
import Swifter

func paramsObject(with request: HttpRequest) -> [String: String] {
    return request.parseUrlencodedForm().reduce([String: String]()) { map, item in
        var _map = map
        _map[item.0] = item.1
        return _map
    }
}

func error(with message: String) -> [String: String] {
    return ["error": message]
}