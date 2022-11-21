//
//  Extensions.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 18/11/22.
//

import UIKit

extension UIImageView {
    
    func imageURLLoad(url: URL) {

        DispatchQueue.global().async { [weak self] in
            
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            
            let urlToString = url.absoluteString as NSString
            
            if let cachedImage = Utilities.getImageCache(url: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    
                    Utilities.setImageCache(image: image, url: urlToString)
                    setImage(image: image)
                }
                
            } else {
                setImage(image: nil)
            }
        }
    }

}
