//
//  ArticleTableCellViewModel.swift
//  News
//
//  Created by Nanter on 5/9/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableCellViewModel {
    
    //MARK: CallBacks
    
    var didImageGot: ((_ image: UIImage?, _ imageUrl: String?) -> Void)?
    
    //MARK: Public functions
    
    func setImage(imageUrl: String?) {
        
        guard let imageUrl = imageUrl else {
            let noImage = #imageLiteral(resourceName: "noImage")
            self.didImageGot?(noImage, nil)
            return
        }
        
        ImageServiseAlamofire.shared.getImage(with: imageUrl) { image in
            self.didImageGot?(image, imageUrl)
        }
    }
}
