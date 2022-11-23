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
        self.heroDetails = HeroDetailViewModel(hero, modelContext: self.context)
    }
    
    //MARK: Actions
    @objc func dismissModal() {
        
        self.heroDetails?.setFavoriteHero() { isSuccess in
            
            if isSuccess {
                self.dismiss(animated: true, completion: nil)
            } else {
               
                let alert = UIAlertController(title: "Ops...", message: "Não foi possivel favoritar este heroi.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }

}

