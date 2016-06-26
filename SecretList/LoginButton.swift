//
//  LoginButton.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/26/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

@IBDesignable class LoginButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.masksToBounds = cornerRadius > 0.0
            layer.cornerRadius = cornerRadius
        }
    }
}
