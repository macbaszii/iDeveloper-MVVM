//
//  LoginContract.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/25/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

protocol LoginViewType: class {

  //intent
  var emailIntent: Flow<String> { get }
  var passwordIntent: Flow<String> { get }
  var loginIntent: Flow<Void> { get }

  //action
  func handleLoginSuccess()
  func handleLoginFailure(error: NSError)
  
}

protocol LoginViewModelType {
  
  var isCredentialValid: Flow<Bool> { get }
  var isNetworkInProgress: Flow<Bool> { get }
  
  func login(username: String, password: String)
  
}
