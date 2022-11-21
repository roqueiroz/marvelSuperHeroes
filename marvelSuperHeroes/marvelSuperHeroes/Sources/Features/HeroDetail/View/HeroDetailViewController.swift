//
//  HeroDetailViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 18/11/22.
//

import UIKit

class HeroDetailViewController: UIViewController {

    private var heroDetailView: HeroDetailView?
    private var heroDetails: HeroDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
            
    override func loadView() {
        
        self.heroDetailView = HeroDetailView()
        self.heroDetailView?.configComponents(heroDetails!)
        self.heroDetailView?.actionSubject = {
            self.dismissModal()
        }
        
        self.view = heroDetailView
        
        
    }
    
    func setHero(_ hero: Hero) {
        self.heroDetails = HeroDetailViewModel(hero)
    }
    
    //MARK: Actions
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }

}

