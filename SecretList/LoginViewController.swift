//
//  LoginViewController.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/25/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

private let SecretListSegueIdentifier = "SecretListSegue"

class LoginViewController: UIViewController
{
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
    }
}

extension LoginViewController
{
    // MARK: - Configuration
    
    private func setupView()
    {
        enableLoginButton(false)
    }
    
    private func enableLoginButton(_ enabled: Bool)
    {
        loginButton?.isEnabled = enabled ? true : false
        loginButton?.alpha = enabled ? 1.0 : 0.5
    }
}

extension LoginViewController
{
    // MARK: - Validation
    
    private var isValidFields: Bool { return emailField?.text?.isValidEmail == true && passwordField?.text?.isValidPassword == true }
}

extension LoginViewController
{
    // MARK: - Alert
    
    private func showAlertWithError(_ error: NSError)
    {
        let alert = UIAlertController(
            title: "Error!",
            message: error.localizedDescription,
            preferredStyle: .alert)
        
        let okAlertAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil)
        
        alert.addAction(okAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController
{
    // MARK: - Actions
    
    @IBAction func fieldDidChange(_ field: UITextField)
    {
        enableLoginButton(isValidFields)
    }
    
    @IBAction func login()
    {
        APIManager.sharedManager
            .login(with: emailField?.text ?? "",
                   and: passwordField?.text ?? "") { [weak self] (token, error) in
                    
                    if let error = error
                    {
                        self?.showAlertWithError(error)
                    }
                    else
                    {
                        self?.performSegue(withIdentifier: SecretListSegueIdentifier, sender: nil)
                    }
        }
    }
}

private let EmailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
private let MinimumPasswordCharacters = 6

private extension String
{
    var isValidEmail: Bool { return self.range(of: EmailRegularExpression, options: .regularExpressionSearch).map() { _ in true } ?? false }
    var isValidPassword: Bool { return self.characters.count >= MinimumPasswordCharacters }
}

