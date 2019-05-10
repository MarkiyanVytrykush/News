//
//  ImageServiseAlamofire.swift
//  News
//
//  Created by Nanter on 5/8/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageServiseAlamofire {

    static let shared = ImageServiseAlamofire()
    private init() { }
    
    private let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    private func request(with imageURL: String, completion: @escaping ((_ image: UIImage?) -> Void)) {
        
        Alamofire.request(imageURL).responseImage { response in
            
            guard let image = response.result.value else {
                let noImage = #imageLiteral(resourceName: "noImage")
                completion(noImage)
                return
            }
            self.imageCache.add(image, withIdentifier: imageURL)
            completion(image)
        }
    }
  
    
    func getImage(with imageURL: String, completion: @escaping ((_ image: UIImage?) -> Void)) {
        if let image = imageCache.image(withIdentifier: imageURL) {
            completion(image)
        } else {
            request(with: imageURL) { image in
                completion(image)
            }
        }
    }
}
