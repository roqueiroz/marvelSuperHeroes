//
//  HeroDetailViewModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 21/11/22.
//

import UIKit
import CoreData

class HeroDetailViewModel {
    
    private var hero: Hero
    private var favoriteHero: FavoriteHeroEntity?
    private var context: NSManagedObjectContext
    
    init(_ hero: Hero, modelContext: NSManagedObjectContext) {
        self.hero = hero
        self.context = modelContext
        
        self.validateFavoriteHero()
    }
    
    func setFavoriteHero(completion: @escaping (_ isSuccess: Bool) -> Void) {
        
        FullScreenLoaderView.show()
        
        do {
            
            if self.hero.isFavorite {
                
                print("deletado dos favoritos")
                
                guard let favoriteHero = self.favoriteHero else {
                    completion(false)
                    return
                }
                
                self.context.delete(favoriteHero)
                try self.context.save()
                
                completion(true)
                
            } else {
                print("incluido nos favoritos")
                
                favoriteHero = FavoriteHeroEntity(context: self.context)
                favoriteHero?.id = Int32(hero.id)
                favoriteHero?.name = hero.name
                favoriteHero?.detail = hero.description
                //favoriteHero?.image = self.getHeroImage()
                
                try self.context.save()
                
                completion(true)
            }
            
        } catch {
            completion(false)
        }
        
        FullScreenLoaderView.hide()

    }
    
    private func validateFavoriteHero() {
        
        guard let favoriteHeroEntity = self.context.fetchFavoriteHeroById(self.hero.id) else {
            self.hero.isFavorite = false
            return
        }
        
        self.favoriteHero = favoriteHeroEntity
        self.hero.isFavorite = true
        
    }
    
    func getButtonTitle() -> String {
        return hero.isFavorite ? "Remover dos Favoritos" : "Incluir nos Favoritos"
    }
    
    func getButtonColor() -> UIColor? {
        return hero.isFavorite ? UIColor(named: "notFavoriteColor") : UIColor(named: "isFavoriteColor")
    }
    
    func getHeroName() -> String {
        return hero.name
    }
    
    func getHeroDescription() -> NSMutableAttributedString {
        
        let normalText = hero.description
        /*
        let normalText = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\n The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
        */
        let boldText  = "Descrição: "
        
        let normalAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
        let normalAttributedString = NSMutableAttributedString(string: normalText, attributes: normalAttrs)

        let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 21)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes:boldAttrs)

        attributedString.append(normalAttributedString)
        
        return attributedString
    }
    
    func getHeroImage() -> URL? {
        
        guard let thumbnail = hero.thumbnail else {
            return URL(string: "")!
        }
        
        let url = "\(thumbnail.path).\(thumbnail.imageType)"
        
        return URL(string: url)!
    }
}
