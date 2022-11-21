//
//  MainViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 16/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeView: HomeView?
    let homeViewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Marvel Super Heroes"
        self.navigationItem.searchController = homeView?.searchBarHero
    }
    
    override func loadView() {
        self.homeView = HomeView()
        self.homeView?.setTableViewProtocols(delegate: self, dataSource: self)
        self.view = homeView
    }
    
    //MARK: Function`s
    private func goToHeroDetail(_ hero: Hero) {
        
        let heroDetailCtrl = HeroDetailViewController()
        heroDetailCtrl.setHero(hero)

        self.navigationController?.present(heroDetailCtrl, animated: true)
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        return 1
        
        var numOfSections: Int = 0
        
        if self.homeViewModel.countListHero > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
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
}
