//
//  ViewController.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

private let SecretListSegueIdentifier = "SecretListSegue"

class LoginViewController : UIViewController {

  @IBOutlet var emailField: UITextField!
  @IBOutlet var passwordField: UITextField!
  @IBOutlet var loginButton: UIButton!
  
  var username = Flow<String>()
  var password = Flow<String>()
  var loginDidTap = Flow<Void>()
  
  var viewModel: LoginViewModelType!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  private func setUp() {
    viewModel = LoginViewModel(view: self)
   
    viewModel.isCredentialValid.subscribeWithCache { [unowned self] enabled in
      guard let enabled = enabled else { return }
      self.loginButton.enabled = enabled
    }
  }
  
  deinit {
    print(#function)
  }
  
}

extension LoginViewController : LoginViewType {

  func handleLoginSuccess() {
    self.performSegueWithIdentifier(SecretListSegueIdentifier, sender: nil)
  }
  
  func handleLoginFailure(error: NSError) {
    let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
    presentViewController(alert, animated: true, completion: nil)
  }
  
}

extension LoginViewController {
  
  @IBAction func usernameTextFieldDidChanged() {
    username.value = emailField.text
  }
  
  @IBAction func passwordDidChanged() {
    password.value = passwordField.text
  }
  
  @IBAction func loginButtonDidTap() {
    loginDidTap.value = Void()
  }
  
}
