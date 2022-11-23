//
//  Extensions.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 18/11/22.
//

import UIKit
import CoreData

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
    
    func imageURLLoad(url: URL?) {
        
        func setImage(image: UIImage?) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        if url == nil {
            setImage(image: UIImage(named: "imgDefault"))
        } else {
            
            DispatchQueue.global().async { [weak self] in
                
                let urlToString = url!.absoluteString as NSString
                
                if let cachedImage = Utilities.getImageCache(url: urlToString) {
                    setImage(image: cachedImage)
                } else if let data = try? Data(contentsOf: url!), let image = UIImage(data: data) {
                    
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
    
}

extension UIViewController {
    
    var context: NSManagedObjectContext {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
        
    }

}

extension NSManagedObjectContext {
    
    func fetchFavoriteHeroById(_ id: Int) -> FavoriteHeroEntity? {
                
        let listFavoriteHeroes = self.fetchFavoriteHeroes()
        
        guard let favoriteHero = listFavoriteHeroes.filter({ item in return item.id == id }).first else {
            return nil
        }
        
        return favoriteHero
    }
    
    func fetchFavoriteHeroes() -> [FavoriteHeroEntity] {
        
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest: NSFetchRequest<FavoriteHeroEntity> = FavoriteHeroEntity.fetchRequest()
        fetchRequest.sortDescriptors = [sort]
        
        do {
            
            let list = try self.fetch(fetchRequest)
            
            return list
            
        } catch {
            return []
        }
        
    }
}

// Fonte: https://github.com/NikolaiRuhe/SwiftDigest/blob/master/SwiftDigest/MD5Digest.swift
// - Copyright: Copyright (c) 2017 Nikolai Ruhe.
public extension Sequence where Element == UInt8 {

    var md5: MD5Digest {
        return MD5Digest(from: Data(self))
    }
}
