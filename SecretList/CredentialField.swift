//
//  CredentialField.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/26/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

@IBDesignable class CredentialField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.masksToBounds = cornerRadius > 0.0
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.clearColor() {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0), NSForegroundColorAttributeName: placeholderColor])
        }
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}
