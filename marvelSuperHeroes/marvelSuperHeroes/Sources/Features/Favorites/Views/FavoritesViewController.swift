//
//  FavoritesViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    private var favoriteView: FavoritesView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Meus Herois"
        self.buildView()
        
        
        FullScreenLoaderView.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            FullScreenLoaderView.hide()
        }
        
    }

    //MARK: Function`s
    private func buildView() {
        view = FavoritesView()
        favoriteView = view as? FavoritesView
    }
    
}

