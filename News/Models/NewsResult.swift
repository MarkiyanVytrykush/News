//
//  NewsResult.swift
//  News
//
//  Created by Nanter on 5/7/19.
//  Copyright © 2019 Nanter. All rights reserved.
//

import UIKit

//MARK: Result

struct NewsResult: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]
}

//MARK: Result

enum Result<T> {
    case success(result: T)
    case failure(error: Error)
}
