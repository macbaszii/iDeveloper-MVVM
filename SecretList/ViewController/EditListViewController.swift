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
}

extension EditListViewController
{
    // MARK: - Validation
    
    private var changed: Bool { return (textField?.text == item?.title) == false }
    private var valid: Bool { return textField?.text?.characters.count > 0 }
}


extension EditListViewController
{
    // MARK: - Actions
    
    @IBAction func fieldDidChange(_ field: UITextField)
    {
        saveBarButtonItem?.isEnabled = (changed && valid)
    }
    
    @IBAction func save()
    {
        item?.title = textField?.text ?? ""
        item?.createdAt = Date()
        
        saveBarButtonItem?.isEnabled = (changed && valid)
    }
}
