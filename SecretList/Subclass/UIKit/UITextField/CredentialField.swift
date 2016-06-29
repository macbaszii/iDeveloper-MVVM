//
//  CredentialField.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/26/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

@IBDesignable class CredentialField: UITextField
{
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.masksToBounds = cornerRadius > 0.0
            self.layer.cornerRadius = cornerRadius } }
    
    @IBInspectable var placeholderColor: UIColor = .clear() {
        didSet {
            self.attributedPlaceholder = AttributedString(
                string: placeholder ?? "",
                attributes: [ NSFontAttributeName: UIFont.systemFont(ofSize: 15.0),
                              NSForegroundColorAttributeName: placeholderColor ]) } }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return bounds.insetBy(dx: 10.0, dy: 0.0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return bounds.insetBy(dx: 10.0, dy: 0.0)
    }
}
