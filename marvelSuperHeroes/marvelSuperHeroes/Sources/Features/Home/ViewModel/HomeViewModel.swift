//
//  HomeViewModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func successRequest()
    func errorRequest()
}

class HomeViewModel {
    
    private var listHero: [Hero] = []
    private let service: Service = Service()
    
    private weak var delegate: HomeViewModelDelegate?
    
    public var countListHero: Int {
        get { self.listHero.count }
    }
    
    init() { }
    
    //MARK: Function`s
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchAllHeroes() {
        
        FullScreenLoaderView.show()
        
        service.getHeroes() { success, error in
            
            if let result = success {
                self.listHero = result
                self.delegate?.successRequest()
            } else {
                self.delegate?.errorRequest()
            }
             
            FullScreenLoaderView.hide()
        }
        
    }
    
    public func loadCurrentHero(index: Int) -> Hero {
        return self.listHero[index]
    }

}
