//
//  Safari.swift
//  News
//
//  Created by Nanter on 5/9/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import UIKit
import SafariServices

class Safari {
    
    static func safariViewController(url: URL) -> UIViewController {
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        
        return safariViewController
    }
}
