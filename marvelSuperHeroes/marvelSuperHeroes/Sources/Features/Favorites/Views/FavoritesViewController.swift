//
//  FavoritesViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

    private var favoriteView: FavoritesView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Meus Herois"
        self.buildView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let list = self.context.fetchFavoriteHeroes()
        
        for item in list {
            print(item.name!)
        }
        
    }

    //MARK: Function`s
    private func buildView() {
        view = FavoritesView()
        favoriteView = view as? FavoritesView
    }
    
}
