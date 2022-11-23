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
    var isFiltering: Bool = false
    
    private var searchName: String = ""
    private var parameters: Dictionary<String, String> = [:]
    private weak var delegate: HomeViewModelDelegate?
    
    public var countListHero: Int {
        get { self.listHero.count }
    }
    
    init() { }
    
    //MARK: Function`s
    func clearParameters() {
        self.isFiltering = false
        self.isPaging = false
        self.searchName = ""
        self.offset = 0
        self.listHero = []
        self.parameters = [:]
    }
    
    func loadBasicParameters() {
        
        if isPaging {
            offset = offset + limit
        } else {
            offset = 0
        }
        
        parameters = ["limit": "\(self.limit)", "offset": "\(self.offset)"]
    }
    
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchAllHeroes(pagination: Bool = false) {
        
        self.isPaging = pagination
        self.loadBasicParameters()
        
        if !pagination {
            FullScreenLoaderView.show()
        }
        
        service.getHeroes(parameters: parameters) { success, error in
            
            if let result = success {
                
                if pagination {
                    self.listHero.append(contentsOf: result)
                } else {
                    self.listHero = result
                }
               
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
    
    func searchHeroByName(_ name: String = "", pagination: Bool = false) {
        
        self.isPaging = pagination
        self.loadBasicParameters()
        
        if !pagination {
            FullScreenLoaderView.show()
        }
        
        if !name.isEmpty {
            self.searchName = name
        }
        
        parameters["nameStartsWith"] = self.searchName.trimmingCharacters(in: CharacterSet.whitespaces)
        
        service.getHeroes(parameters: parameters) { success, error in
            
            if let result = success {
                
                if pagination {
                    self.listHero.append(contentsOf: result)
                } else {
                    self.listHero = result
                }
                
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
