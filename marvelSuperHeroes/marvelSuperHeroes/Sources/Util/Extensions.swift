//
//  Extensions.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 18/11/22.
//

import UIKit


extension UITableView {
    
    func showFooterLoading(_ show: Bool) {
        
        if show {
            
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
            
            let spinner = UIActivityIndicatorView()
            spinner.center = footerView.center
            spinner.startAnimating()
            
            footerView.addSubview(spinner)
            
            self.tableFooterView = footerView
            
        } else {
            self.tableFooterView = nil
        }
        
    }
    
}

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
