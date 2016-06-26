//
//  LoginViewModel.swift
//  SecretList
//
//  Created by Kittinun Vantasin on 6/25/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import Foundation

class LoginViewModel {

  let isCredentialValid = Flow(false)
  let isNetworkInProgress = Flow(false)
  
  weak var view: LoginViewType?
  
  init(view: LoginViewType) {
    self.view = view
    
    view.emailIntent.subscribe { [unowned self] text in
      self.isCredentialValid.value = self.validateEmailAndPassword(text, password: view.passwordIntent.value)
    }
    
    view.passwordIntent.subscribe { [unowned self] text in
      self.isCredentialValid.value = self.validateEmailAndPassword(view.emailIntent.value, password: text)
    }
    
    view.loginIntent.subscribe { [unowned self] _ in
      guard let email = view.emailIntent.value, password = view.passwordIntent.value else { return }
      self.login(email, password: password)
    }
  }
  
  private func validateEmailAndPassword(email: String?, password: String?) -> Bool {
    guard let email = email, password = password else { return false }
    return email.isValidEmail() && password.isValidPassword()
  }
  
}

extension LoginViewModel : LoginViewModelType {
  
  func login(email: String, password: String) {
    isNetworkInProgress.value = true
    
    APIManager.sharedManager.login(with: email, and: password) { [unowned self] token, error in
      self.isNetworkInProgress.value = false
      if let error = error {
        self.view?.handleLoginFailure(error)
      } else {
        self.view?.handleLoginSuccess()
      }
    }
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