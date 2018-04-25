//
//  ImageCache.swift
//  TestingPractice
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageCache {
    private init() {}
    static let manager = ImageCache()
    private let imageCache = NSCache<NSString, UIImage>()
    
    public func storeImage(image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    public func retrieveImage(withKey key: String) -> UIImage? {
        if let image = imageCache.object(forKey: key as NSString) {
            return image
        }
        return nil
    }
}
