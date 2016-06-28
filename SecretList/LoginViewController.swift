//
//  ViewController.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

private let SecretListSegueIdentifier = "SecretListSegue"

class LoginViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension LoginViewController {
    // MARK: - Actions
    
    @IBAction func fieldDidChange(field: UITextField) {
        enableLoginButton(isValidFields())
    }
    
    @IBAction func login() {
        APIManager.sharedManager.login(with: emailField.text!,
                                       and: passwordField.text!) { (token, error) in
                                        
                                        if let error = error {
                                            self.showAlert(with: error)
                                        } else {
                                            self.performSegueWithIdentifier(SecretListSegueIdentifier, sender: nil)
                                        }
        }
    }
    
    // MARK: - Internal Methods
    
    private func isValidFields() -> Bool {
        return emailField.text?.isValidEmail() == true &&
                passwordField.text?.isValidPassword() == true
    }
    
    private func enableLoginButton(enabled: Bool) {
        loginButton.enabled = enabled ? true : false
        loginButton.alpha = enabled ? 1.0 : 0.5
    }
    
    private func setupView() {
        enableLoginButton(false)
    }    
}

private let EmailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
private let MinimumPasswordCharacters = 6

private extension String {
    func isValidEmail() -> Bool {
        if let _ = self.rangeOfString(EmailRegularExpression, options: .RegularExpressionSearch) {
            return true
        }
        
        return false
    }
    
    func isValidPassword() -> Bool {
        return self.characters.count >= MinimumPasswordCharacters
    }
}

