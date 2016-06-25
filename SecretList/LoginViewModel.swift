//
//  LoginViewModel.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/25/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class LoginViewModel : LoginViewModelType {

  let isCredentialValid = Flow(false)
  
  weak var view: LoginViewType?
  
  init(view: LoginViewType) {
    self.view = view
    
    view.username.subscribe { [unowned self] usernameText in
      self.isCredentialValid.value = self.validateUsernameAndPassword(usernameText, password: view.password.value)
    }
    
    view.password.subscribe { [unowned self] passwordText in
      self.isCredentialValid.value = self.validateUsernameAndPassword(view.username.value, password: passwordText)
    }
    
    view.loginDidTap.subscribe { [unowned self] _ in
      guard let username = view.username.value, password = view.password.value else { return }
      self.login(username, password: password)
    }
  }
  
  func login(username: String, password: String) {
    APIManager.sharedManager.login(with: username, and: password) { [unowned self] token, error in
      if let error = error {
        self.view?.handleLoginFailure(error)
      } else {
        self.view?.handleLoginSuccess()
      }
    }
  }
  
  private func validateUsernameAndPassword(username: String?, password: String?) -> Bool {
    guard let username = username, password = password else { return false }
    return username.isValidEmail() && password.isValidPassword()
  }
  
}

private let EmailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
private let MinimumPasswordCharacters = 6

private extension String {

  func isValidEmail() -> Bool {
    if let _ = rangeOfString("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .RegularExpressionSearch) {
        return true
    }
    return false
  }
  
  func isValidPassword() -> Bool {
    return characters.count >= MinimumPasswordCharacters
  }
  
}