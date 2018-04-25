//
//  MovieAPI.swift
//  TestingPractice
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(url: String)
    case badImageURL(url: String)
    case badData
    case badResponseCode(code: Int)
    case cannotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
}

class MovieAPI {
    private init() {}
    static let manager = MovieAPI()
    func searchMovies(keyword: String, completionHandler: @escaping (Error?, Data?) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=movie&term=comedy&limit=10"
        guard let url = URL(string: urlString) else {
            completionHandler(AppError.badURL(url: urlString), nil)
            return
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            completionHandler(nil, data)
        }, errorHandler: { (error) in
            completionHandler(AppError.other(rawError: error), nil)
        })
    }
}
