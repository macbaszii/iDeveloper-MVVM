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
  @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!

  let emailIntent = Flow<String>()
  let passwordIntent = Flow<String>()
  let loginIntent = Flow<Void>()

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

    viewModel.isNetworkInProgress.subscribe { [unowned self] inProgress in
      guard let inProgress = inProgress else { return }
      if inProgress {
        self.loginButton.alpha = 0.0
        self.loadingIndicatorView.startAnimating()
      } else {
        self.loginButton.alpha = 1.0
        self.loadingIndicatorView.stopAnimating()
      }
    }
  }

}

extension LoginViewController : LoginViewType {

  func handleLoginSuccess() {
    performSegueWithIdentifier(SecretListSegueIdentifier, sender: nil)
  }

  func handleLoginFailure(error: NSError) {
    let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))

    presentViewController(alert, animated: true, completion: nil)
  }

}

extension LoginViewController {

  @IBAction func usernameTextFieldDidChanged() {
    emailIntent.value = emailField.text
  }

  @IBAction func passwordTextFieldDidChanged() {
    passwordIntent.value = passwordField.text
  }

  @IBAction func loginButtonDidTap() {
    loginIntent.value = Void()
  }

}
