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
//        searchBarCtrl.searchBar.delegate = self
//        searchBarCtrl.searchResultsUpdater = self
        searchBarCtrl.searchBar.placeholder = "Pesquisar por nome..."
        searchBarCtrl.obscuresBackgroundDuringPresentation = false
        searchBarCtrl.searchBar.sizeToFit()
        searchBarCtrl.searchBar.searchBarStyle = .prominent
        
        
        return searchBarCtrl
    }()
    
    lazy var tblHeroes: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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
    
    private func addSubViews() {
        
        addSubview(tblHeroes)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        
        let constraints = [

            tblHeroes.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tblHeroes.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tblHeroes.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tblHeroes.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
}

