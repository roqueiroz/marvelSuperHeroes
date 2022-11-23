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
                favoriteHero?.image = hero.imageUrl
                
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

        let boldText  = "Descrição: "
        
        let normalAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
        let normalAttributedString = NSMutableAttributedString(string: normalText, attributes: normalAttrs)

        let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 21)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes:boldAttrs)

        attributedString.append(normalAttributedString)
        
        return attributedString
    }
    
    func getHeroImage() -> URL? {
        
        return URL(string: hero.imageUrl)
    }
}
