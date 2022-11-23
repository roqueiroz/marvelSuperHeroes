//
//  FavoritesViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

    private var favoriteView: FavoritesView?
    var favoriteViewModel: FavoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Meus Herois"
        
        self.favoriteViewModel.delegate(delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoriteViewModel.fetchFavoriteHeroes(with: self.context)
        self.favoriteView?.reloadTableView()
    }
    
    override func loadView() {
        self.favoriteView = FavoritesView()
        
        self.view = favoriteView
    }

    //MARK: Function`s
    private func goToHeroDetail(_ hero: Hero) {
        
        let heroDetailCtrl = HeroDetailViewController()
        heroDetailCtrl.setHero(hero)
        heroDetailCtrl.refreshDataDelegate = self

        self.navigationController?.present(heroDetailCtrl, animated: true)
        
    }
}

//MARK: UITableView Delegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
       
        var numOfSections: Int = 0

        if self.favoriteViewModel.countFavoritesHeroes > 0 {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            self.favoriteView?.setMessageError(msg: "Sem Herois Favoritos!")
        }

        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteViewModel.countFavoritesHeroes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let hero = self.favoriteViewModel.getHero(index: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTableViewCell") as? HeroTableViewCell
        cell?.setupCell(hero: hero)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hero = favoriteViewModel.getHero(index: indexPath.row)
        
        self.goToHeroDetail(hero)
    }
    
    
}

//MARK: ViewModel Delegate
extension FavoritesViewController: HomeViewModelDelegate {
    
    func successRequest() {
        self.favoriteView?.setTableViewProtocols(delegate: self, dataSource: self)
        self.favoriteView?.reloadTableView()
    }
    
    func errorRequest() {

    }
    
}

extension FavoritesViewController: RefreshDataDelegate {
    
    func refreshData() {
        self.favoriteViewModel.fetchFavoriteHeroes(with: self.context)
        self.favoriteView?.reloadTableView()
    }
}

