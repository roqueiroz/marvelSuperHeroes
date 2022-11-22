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
    
    private var limit = 10
    private var offset = 0
    private var listHero: [Hero] = []
    private let service: Service = Service()
    
    var isPaging: Bool = false
    
    private weak var delegate: HomeViewModelDelegate?
    
    public var countListHero: Int {
        get { self.listHero.count }
    }
    
    init() { }
    
    //MARK: Function`s
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchAllHeroes(pagination: Bool = false) {
        
        isPaging = pagination
        
        if !pagination {
            FullScreenLoaderView.show()
        }
       
        if pagination {
            offset = offset + limit
        }
        
        let parameters = ["limit": "\(self.limit)", "offset": "\(self.offset)"]
        
        service.getHeroes(parameters: parameters) { success, error in
            
            if let result = success {
                
                self.listHero.append(contentsOf: result)
                
                self.delegate?.successRequest()
                
            } else {
                self.delegate?.errorRequest()
            }
             
            FullScreenLoaderView.hide()
            
            if pagination {
                self.isPaging = false
            }
        }
        
    }
    
    public func loadCurrentHero(index: Int) -> Hero {
        return self.listHero[index]
    }

}
