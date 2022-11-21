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
        
        let normalAttributedString = NSMutableAttributedString(string: normalText)

        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes:attrs)

        attributedString.append(normalAttributedString)
        
        return attributedString
    }
    
    func getHeroImage() -> URL? {
        return URL(string: hero.urlImage)
    }
}
