//
//  FavoritesView.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class FavoritesView: UIView {
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Meus Herois"
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        self.addSubViews()
    }
    
    //MARK: Function`s
    private func addSubViews() {
        
        addSubview(lblTitle)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        
        let constraints = [
            lblTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -45),
            lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
}
