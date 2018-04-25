//
//  ImageService.swift
//  TestingPractice
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageService {
    private init() {}
    static let manager = ImageService()
    public func getImage(withURL url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        if let image = ImageCache.manager.retrieveImage(withKey: url.absoluteString) {
            completionHandler(image)
        } else {
            NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
                if let image = UIImage(data: data) {
                    completionHandler(image)
                } else {
                    completionHandler(nil)
                }
            }, errorHandler: { (error) in
                print(error)
                completionHandler(nil)
            })
        }
    }
}
