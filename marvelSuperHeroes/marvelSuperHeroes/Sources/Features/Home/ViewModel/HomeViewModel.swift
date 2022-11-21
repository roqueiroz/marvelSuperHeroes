//
//  HomeViewModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class HomeViewModel {
    
    private var listHero: [Hero] = []
    
    public var countListHero: Int {
        get { self.listHero.count }
    }
    
    init() {
        self.configArrayHero()
    }
    
    //MARK: Function`s
    private func configArrayHero() {
                
        self.listHero.append(Hero(id: 1011334, name: "3-D Man", description: "", urlImage: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", isFavorite: false))
        self.listHero.append(Hero(id: 1017100, name: "A.I.M.", description: "", urlImage: "https://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec.jpg", isFavorite: false))
        self.listHero.append(Hero(id: 1017100, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ", urlImage: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg", isFavorite: false))
        self.listHero.append(Hero(id: 1017100, name: "Abomination (Emil Blonsky)", description: "", urlImage: "https://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg", isFavorite: false))
        self.listHero.append(Hero(id: 1017100, name: "Absorbing Man", description: "", urlImage: "https://i.annihil.us/u/prod/marvel/i/mg/1/b0/5269678709fb7.jpg", isFavorite: false))
        
    }
    
    public func loadCurrentHero(index: Int) -> Hero {
        return self.listHero[index]
    }

}
