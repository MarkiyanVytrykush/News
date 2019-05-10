//
//  Alert.swift
//  News
//
//  Created by Nanter on 5/10/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(title: String = "Error", message: String?, button: String = "Ok", action: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: action))
        self.present(alert, animated: true, completion: nil)
    }
}
