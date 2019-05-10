//
//  NewsTableViewModel.swift
//  News
//
//  Created by Nanter on 5/7/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import Foundation
import UIKit

class NewsTableViewModel {
    
    var source: Source?
    var allNews = [Article]()
    var page = 1
    
    //MARK: - CallBacks
    
    var didGotData: (() -> Void)?
    var didError: ((_ error: Error) -> Void)?

    //MARK: - Init

    init() {
        self.getData()
    }
    
    func getData(searchParam: String? = nil) {
        
        NetworkManager.shared.request(request: ApiRouter.topHeadlinesForCountry(page: 1 , search: searchParam), type: NewsResult.self) { (result) in
            switch result {
            case .success(let data):
                self.allNews = data.articles
                self.didGotData?()
            case .failure(let error):
                guard error.localizedDescription != "cancelled" else { return }
                self.didError?(error)
            }
        }
    }
}

