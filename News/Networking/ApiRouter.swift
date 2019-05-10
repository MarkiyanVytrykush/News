////
////  ApiRouter.swift
////  News
////
////  Created by Nanter on 5/5/19.
////  Copyright © 2019 Nanter. All rights reserved.
////

import UIKit
import Alamofire

// MARK : Api Router

enum ApiRouter {
    case topHeadlinesForCountry(page: Int, search: String?)
}

extension ApiRouter: URLRequestConvertible {
    
    private struct Constants {
        private init() { }
        static let apiKey = "3176a4df996f41adb0d5906a7387497f"
        static let baseURL = "https://newsapi.org"
        static let path = "/v2/top-headlines"
        static let country = "ua"
        static let perPage = 100
    }
    
    var method: HTTPMethod {
        switch self {
        case .topHeadlinesForCountry:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .topHeadlinesForCountry:
            return "/v2/top-headlines"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .topHeadlinesForCountry(let page, let search):
            var parametres = [String: Any]()
            parametres["page"] = "\(page)"
            parametres["q"] = search
            parametres["apiKey"] = Constants.apiKey
            parametres["country"] = Constants.country
            parametres["page_size"] = Constants.perPage
            return parametres
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
