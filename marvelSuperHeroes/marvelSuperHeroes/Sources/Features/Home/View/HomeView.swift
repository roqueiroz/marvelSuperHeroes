//
//  MainView.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 16/11/22.
//

import UIKit

class HomeView: UIView {
        
    lazy var searchBarHero: UISearchController = {
        
        let searchBarCtrl = UISearchController(searchResultsController: nil)
        searchBarCtrl.searchBar.placeholder = "Pesquisar por nome..."
        searchBarCtrl.obscuresBackgroundDuringPresentation = false
        searchBarCtrl.searchBar.sizeToFit()
        searchBarCtrl.searchBar.searchBarStyle = .prominent
        searchBarCtrl.navigationController?.hidesBarsOnSwipe = false
        
        return searchBarCtrl
    }()
    
    lazy var tblHeroes: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        tableView.register(HeroTableViewCell.self, forCellReuseIdentifier: "HeroTableViewCell")

        return tableView
    }()
    
    convenience init() {
        self.init(frame: .zero)

        self.addSubViews()

    }
    
    //MARK: Function`s
    public func setTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tblHeroes.delegate = delegate
        self.tblHeroes.dataSource = dataSource
    }
    
    public func setSeachBarProtocols(delegate: UISearchBarDelegate, resultsUpdate: UISearchResultsUpdating) {
        self.searchBarHero.searchBar.delegate = delegate
        self.searchBarHero.searchResultsUpdater = resultsUpdate
    }
    
    func reloadTableView() {
        self.tblHeroes.reloadData()
    }
    
    func showFooterLoading(_ show: Bool) {
        self.tblHeroes.showFooterLoading(show)
    }
    
    private func addSubViews() {
        
        addSubview(tblHeroes)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        
        let constraints = [

            tblHeroes.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tblHeroes.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tblHeroes.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tblHeroes.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}

