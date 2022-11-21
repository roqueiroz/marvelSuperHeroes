//
//  HeroDetailView.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 18/11/22.
//

import UIKit

class HeroDetailView: UIView {
    
    var actionSubject: (() -> (Void))?
    weak var delegate: setFavoriteHeroDelegate?
    
    private lazy var imgHero: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private lazy var tvDescription: UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textAlignment = .left
        textView.textColor = .black
        textView.isEditable = false
        
        return textView
    }()
    
    private lazy var btnFavorite: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 1.00, green: 0.84, blue: 0.00, alpha: 1.00)
        btn.setTitle("Incluir nos Favoritos", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 17
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(setFavotireHero), for: .touchUpInside)
        
        return btn
    }()
    
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = .white
        
        self.addSubViews()
    }
    
    func configComponents(_ heroDetails: HeroDetailViewModel) {
        
        self.lblTitle.text = heroDetails.getHeroName()
        self.tvDescription.attributedText = heroDetails.getHeroDescription()
        self.btnFavorite.setTitle(heroDetails.getButtonTitle(), for: .normal)
        self.btnFavorite.backgroundColor = heroDetails.getButtonColor()
        
        self.imgHero.imageURLLoad(url: heroDetails.getHeroImage()!)
    }
    
    private func addSubViews() {
        
        addSubview(self.imgHero)
        addSubview(self.lblTitle)
        addSubview(self.tvDescription)
        addSubview(self.btnFavorite)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        
        let constraints = [
            
            self.imgHero.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            self.imgHero.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            self.imgHero.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            self.imgHero.heightAnchor.constraint(equalToConstant: 260),
            
            self.lblTitle.topAnchor.constraint(equalTo: self.imgHero.bottomAnchor, constant: 10),
            self.lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            self.btnFavorite.heightAnchor.constraint(equalToConstant: 46),
            self.btnFavorite.leadingAnchor.constraint(equalTo: self.imgHero.leadingAnchor),
            self.btnFavorite.trailingAnchor.constraint(equalTo: self.imgHero.trailingAnchor),
            self.btnFavorite.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            self.tvDescription.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 10),
            self.tvDescription.leadingAnchor.constraint(equalTo: self.imgHero.leadingAnchor),
            self.tvDescription.trailingAnchor.constraint(equalTo: self.imgHero.trailingAnchor),
            self.tvDescription.bottomAnchor.constraint(equalTo: self.btnFavorite.topAnchor, constant: -10),
            
        ]
        
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    @objc func setFavotireHero() {
        
        self.actionSubject?()
        
        print("click no botao...")
    }
}

protocol setFavoriteHeroDelegate: AnyObject {
    func onClickView(_ sender: UIView)
}
