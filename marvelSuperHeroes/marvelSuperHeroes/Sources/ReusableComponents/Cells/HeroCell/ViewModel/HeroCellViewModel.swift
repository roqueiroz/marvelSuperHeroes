//
//  HeroCellViewModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class HeroCellViewModel {
    
    private var hero: Hero
    
    public var getHero: Hero {
        return self.hero
    }
    
    var getName: String {
        return self.hero.name
    }
    
    var getUrlImage: URL? {
        
        if let url = URL(string: hero.imageUrl) {
            return url
        }
        
        return nil
        
    }
    
    var getDescription: String {
        return "Description: \(hero.description)"
    }
    
    var isFavorite: Bool {
        return self.hero.isFavorite
    }
    
    init(hero: Hero) {
        self.hero = hero
    }
    

}
