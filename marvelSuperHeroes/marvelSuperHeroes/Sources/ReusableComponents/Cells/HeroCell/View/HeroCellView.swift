//
//  HeroCellView.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class HeroCellView: UIView {
    
    lazy var imgHero: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    lazy var btnFavorite: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        self.addSubViews()
    }
    
    private func addSubViews() {
        
        addSubview(imgHero)
        addSubview(lblName)

        self.configConstraints()
    }
    
    private func configConstraints() {
        
        let constraints = [
            
            
            self.lblName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.lblName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.lblName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            self.imgHero.topAnchor.constraint(equalTo: topAnchor),
            self.imgHero.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            self.imgHero.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            self.imgHero.bottomAnchor.constraint(equalTo: self.lblName.topAnchor, constant: -5),

        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
}
