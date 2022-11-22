//
//  HeroDetailViewModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 21/11/22.
//

import UIKit

class HeroDetailViewModel {
    
    private var hero: Hero
    
    init(_ hero: Hero) {
        self.hero = hero
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
        
        guard let thumbnail = hero.thumbnail else {
            return URL(string: "")!
        }
        
        let url = "\(thumbnail.path).\(thumbnail.imageType)"
        
        return URL(string: url)!
    }
}
