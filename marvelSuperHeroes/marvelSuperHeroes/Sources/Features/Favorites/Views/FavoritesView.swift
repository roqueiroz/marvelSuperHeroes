//
//  FavoritesView.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class FavoritesView: UIView {
    
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
    func setTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tblHeroes.delegate = delegate
        self.tblHeroes.dataSource = dataSource
    }
    
    func setMessageError(msg: String) {
        
        let height = tblHeroes.bounds.size.height
        let width = tblHeroes.bounds.size.width
        
        let lblMsgError: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        lblMsgError.text = msg
        lblMsgError.textColor = UIColor.black
        lblMsgError.textAlignment = .center
        lblMsgError.font = UIFont.systemFont(ofSize: 24)
        
        tblHeroes.backgroundView = lblMsgError
        tblHeroes.separatorStyle = .none
        
    }
    
    func reloadTableView() {
        self.tblHeroes.reloadData()
    }
    
    private func addSubViews() {
        
        addSubview(tblHeroes)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        
        let constraints = [

            tblHeroes.topAnchor.constraint(equalTo: self.topAnchor),
            tblHeroes.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tblHeroes.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tblHeroes.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
        
    }
    
}
