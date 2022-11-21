//
//  Utilities.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 18/11/22.
//

import UIKit

public class Utilities {
    
    private static var imagesCache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    static func setImageCache(image: UIImage, url: NSString) {
        
        if imagesCache.object(forKey: url) == nil {
            imagesCache.setObject(image, forKey: url)
        }
        
    }
    
    static func getImageCache(url: NSString) -> UIImage? {
        
        if let cachedImage = imagesCache.object(forKey: url) {
            return cachedImage
        }
        
        return nil
    }
    
}
