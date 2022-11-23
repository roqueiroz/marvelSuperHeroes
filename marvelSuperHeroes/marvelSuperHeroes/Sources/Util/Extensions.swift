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

    /// Computes md5 digest value of contained bytes.
    ///
    /// This extension on `Sequence` is the main API to create `MD5Digest` values.
    /// It is usable on all collection types that use bytes as elements, for instance
    /// `Data` or `String.UTF8View`:
    ///
    /// ## Example:
    ///
    /// Print the md5 of a string's UTF-8 representation
    ///
    ///     let string = "The quick brown fox jumps over the lazy dog"
    ///     print("md5: \(string.utf8.md5)")
    ///     // prints "md5: 9e107d9d372bb6826bd81d3542a419d6"
    ///
    /// Check if a file's contents match a digest
    ///
    ///     let expectedDigest = MD5Digest(rawValue: "9e107d9d372bb6826bd81d3542a419d6")!
    ///     let data = try Data(contentsOf: someFileURL)
    ///     if data.md5 != expectedDigest {
    ///         throw .digestMismatchError
    ///     }
    var md5: MD5Digest {
        return MD5Digest(from: Data(self))
    }
}
