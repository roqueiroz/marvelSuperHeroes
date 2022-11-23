//
//  ApiGlobalVariables.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 21/11/22.
//

import Foundation

class ApiGlobalVariables {
    
    private static func getPrivateKey() -> String {
        let privateKey = "6f9b74eaadf8c925ae54b59c4bcc8b8e554a2563"
        
        return privateKey
    }
    
    class func getHASH() -> String {
        
        var hash: String = ""
                
        let str = "\(getTSParameter())\(getPrivateKey())\(getApiKey())"
        
        hash = "\(str.utf8.md5)"
        
        return hash
    }
    
    class func getTSParameter() -> String {
        
        return String(1)
    }
    
    class func getApiKey() -> String {
        let publicKey = "7b67f05995567256643c104d071e7e9a"
        
        return publicKey
    }
    
    class func getBaseUrl() -> String {
        let baseURL: String = "https://gateway.marvel.com"
        
        return baseURL
    }
}
