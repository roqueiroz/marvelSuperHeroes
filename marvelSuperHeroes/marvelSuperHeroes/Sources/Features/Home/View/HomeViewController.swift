//
//  MainViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 16/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeView: HomeView?
    var homeViewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Marvel Super Heroes"
        self.navigationItem.searchController = homeView?.searchBarHero
        
        self.homeViewModel.delegate(delegate: self)
        self.homeView?.setSeachBarProtocols(delegate: self)
        self.homeViewModel.fetchAllHeroes()
    }
    
    override func loadView() {
        self.homeView = HomeView()
       
        self.view = homeView
    }
    
    //MARK: Function`s
    private func goToHeroDetail(_ hero: Hero) {
        
        let heroDetailCtrl = HeroDetailViewController()
        heroDetailCtrl.setHero(hero)

        self.navigationController?.present(heroDetailCtrl, animated: true)
        
    }
    
}

//MARK: UISearchBar Delegate
extension HomeViewController: UISearchBarDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let name = searchBar.text else {
            return
        }
        
        self.homeViewModel.isFiltering = true
        self.homeViewModel.searchHeroByName(name, pagination: false)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.homeViewModel.clearParameters()
        self.homeViewModel.fetchAllHeroes()
    }
    
}

//MARK: UITableView Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        var numOfSections: Int = 0

        if self.homeViewModel.countListHero > 0 {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            self.homeView?.setMessageError(msg: "Nenhum Heroi encontrado!")
        }

        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.countListHero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTableViewCell") as? HeroTableViewCell
        cell?.setupCell(hero: homeViewModel.loadCurrentHero(index: indexPath.row))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hero = homeViewModel.loadCurrentHero(index: indexPath.row)
        
        self.goToHeroDetail(hero)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        let scrollFrame = scrollView.frame.size.height
        
        guard let tblHeight = self.homeView?.tblHeroes.contentSize.height
        else {
            return
        }
        
        guard !self.homeViewModel.isPaging else {
            return
        }
        
        if position > (tblHeight - scrollFrame) {
            
            if self.homeViewModel.isFiltering {
                self.homeView?.showFooterLoading(true)
                self.homeViewModel.searchHeroByName(pagination: true)
            } else {
                self.homeView?.showFooterLoading(true)
                self.homeViewModel.fetchAllHeroes(pagination: true)
            }
        }
        
    }
}

//MARK: ViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    
    func successRequest() {
        self.homeView?.setTableViewProtocols(delegate: self, dataSource: self)
        self.homeView?.showFooterLoading(false)
        self.homeView?.reloadTableView()
    }
    
    func errorRequest() {
        
        self.homeViewModel.clearParameters()
        self.homeView?.reloadTableView()
        self.homeView?.setMessageError(msg: "Ops, algo deu erro...")
    }
    
}
