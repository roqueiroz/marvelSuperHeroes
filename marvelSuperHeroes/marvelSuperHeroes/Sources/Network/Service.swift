//
//  Service.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 21/11/22.
//

import Foundation
import Alamofire

protocol GenericService: AnyObject {
    typealias completion <T> = (_ result: T, _ failure: Error?) -> Void
}

protocol ServiceDelegate: GenericService {
    func getHeroesFromJson(fromFileNamed name: String, searchByName: String, completion: @escaping completion<[Hero]?>)
    func getHeroes(parameters: Dictionary<String, String>, completion: @escaping completion<[Hero]?>)
}

enum Error: Swift.Error {
    case fileNotFound(name: String)
    case fileDecodingFailed(name: String, Swift.Error)
    case errorRequest(AFError)
}

class Service: ServiceDelegate {
    
    func getHeroes(parameters: Dictionary<String, String> = [:], completion: @escaping completion<[Hero]?>) {
    
        var url: String = "\(ApiGlobalVariables.getBaseUrl())/v1/public/characters?"
        let basicParameters = loadBasicParameters()
        
        for (key, value) in basicParameters {
            url.append("\(key)=\(value)&")
        }
        
        for (key, value) in parameters {
            url.append("\(key)=\(value)&")
        }
        
        AF.request(url, method: .get).validate(statusCode: 200...299).responseDecodable(of: Response.self) { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let success):
                print("SUCESSO")
                completion(success.data.results, nil)
                
            case .failure(let error):
                print("ERROR")
                completion(nil, .errorRequest(error))
                
            }
            
        }
        
    }
    
    func getHeroesFromJson(fromFileNamed name: String, searchByName: String = "", completion: @escaping completion<[Hero]?>) {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return completion(nil, Error.fileNotFound(name: name))
        }
            
        do {
            
            let data = try Data(contentsOf: url)
            
            let response = try JSONDecoder().decode(Response.self, from: data)
            
            if !searchByName.isEmpty {
                let searchFoundHero = response.data.results.filter { $0.name == searchByName }
                
                completion(searchFoundHero, nil)
                return
            }
            
            completion(response.data.results, nil)
            
        } catch {
            completion(nil, .fileDecodingFailed(name: name, error))
        }
        
    }

    private func loadBasicParameters() -> Dictionary<String, String> {
        
        let parameters = [
            "ts": ApiGlobalVariables.getTSParameter(),
            "apikey": ApiGlobalVariables.getApiKey(),
            "hash": ApiGlobalVariables.getHASH()
        ]
        
        return parameters
    }
}
