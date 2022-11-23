//
//  HeroTableViewCell.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
        
    var heroCellViewModel: HeroCellViewModel?
    var viewHero: HeroCellView = HeroCellView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.viewHero.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.viewHero)
        self.configViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(hero: Hero) {
        self.heroCellViewModel = HeroCellViewModel(hero: hero)
        
        self.viewHero.lblName.text = self.heroCellViewModel?.getName
        
        self.viewHero.imgHero.imageURLLoad(url: self.heroCellViewModel?.getUrlImage)
    }

    private func configViewCell() {
       
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            self.viewHero.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.viewHero.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.viewHero.topAnchor.constraint(equalTo: self.topAnchor),
            self.viewHero.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    func setImage(strUrl: String) {
        
        guard let imageURL = URL(string: strUrl) else { return }
        
        DispatchQueue.global().async {

             guard let imageData = try? Data(contentsOf: imageURL) else { return }

             let image = UIImage(data: imageData)

             DispatchQueue.main.async {
                 self.viewHero.imgHero.image = image
             }
         }
        
    }
   
}

