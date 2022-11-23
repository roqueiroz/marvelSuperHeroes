//
//  FavoriteViewModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 23/11/22.
//

import Foundation
import CoreData

class FavoritesViewModel {
    
    private weak var delegate: HomeViewModelDelegate?
    
    private var listHero: [Hero] = []
    
    var countFavoritesHeroes: Int {
        get { self.listHero.count }
    }
    
    init() { }
    
    func fetchFavoriteHeroes(with context: NSManagedObjectContext) {
        
        listHero = []
        let listEntityHeroes = context.fetchFavoriteHeroes()
        
        for entity in listEntityHeroes {
            
            guard let name = entity.name,
                  let detail = entity.detail,
                  let imageUrl  = entity.image
            else {
                return
            }
            
            listHero.append(
                Hero(
                    id: Int(entity.id),
                    name: name,
                    description: detail,
                    imageUrl: imageUrl,
                    isFavorite: true)
            )
            
        }
        
        self.delegate?.successRequest()
        
    }
    
    func getHero(index: Int) -> Hero {
        return self.listHero[index]
    }
    
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
}
