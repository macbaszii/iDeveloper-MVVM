//
//  Flow.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/25/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class Flow<T> {
  typealias Listener = T? -> Void
  
  var value: T? {
    didSet {
      listener?(value)
    }
  }
  
  private var listener: Listener?
  
  init(_ value: T?) {
    self.value = value
  }
  
  convenience init() {
    self.init(nil)
  }
  
  func subscribe(listener: Listener) {
    self.listener = listener
  }
  
  func subscribeWithCache(listener: Listener) {
    subscribe(listener)
    listener(value)
  }
  
  func unsubscribe() {
    listener = nil
  }
  
  deinit {
    listener = nil
  }
  
}