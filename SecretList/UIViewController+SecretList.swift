//
//  UIViewController+SecretList.swift
//  SecretList
//
//  Created by Kiattisak Anoochitarom on 6/28/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with error: NSError) {
        let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
