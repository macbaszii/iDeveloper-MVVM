//
//  EditListViewController.swift
//  SecretList
//
//  Created by Wipoo Shinsirikul on 29/6/16.
//  Copyright © 2016 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

class EditListViewController: UIViewController
{
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    private var observerToken: NSObjectProtocol?
    
    weak var item: Item? {
        didSet {
            textField?.text = item?.title
            saveBarButtonItem?.isEnabled = (changed && valid) } }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        textField?.text = item?.title
        saveBarButtonItem?.isEnabled = (changed && valid)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        observerToken = NotificationCenter
            .default()
            .addObserver(
                forName: NSNotification.Name.UITextFieldTextDidChange,
                object: nil,
                queue: nil) { _ in
                    self.saveBarButtonItem?.isEnabled = (self.changed && self.valid) }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        if let observerToken = observerToken
        {
            NotificationCenter.default().removeObserver(observerToken)
            self.observerToken = nil
        }
    }
}

extension EditListViewController
{
    // MARK: - Validation
    
    private var changed: Bool { return (textField?.text == item?.title) == false }
    private var valid: Bool { return textField?.text?.characters.count > 0 }
}

extension EditListViewController
{
    // MARK: - Notification
    
    @objc private func textFieldTextDidChange(notification: Notification)
    {
        saveBarButtonItem?.isEnabled = (changed && valid)
    }
}

extension EditListViewController
{
    // MARK: - Actions
    
//    @IBAction func fieldDidChange(_ field: UITextField)
//    {
//        saveBarButtonItem?.isEnabled = (changed && valid)
//    }
    
    @IBAction func save()
    {
        item?.title = textField?.text ?? ""
        item?.createdAt = Date()
        
        saveBarButtonItem?.isEnabled = (changed && valid)
    }
}
