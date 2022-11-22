//
//  ApiGlobalVariables.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 21/11/22.
//

import Foundation

class ApiGlobalVariables {
    
    class func getHASH() -> String {
        
        let publicKey = "7b67f05995567256643c104d071e7e9a"
        let privateKey = "6f9b74eaadf8c925ae54b59c4bcc8b8e554a2563"
        var hash: String = "82dd9e102275f0a8c2f00ca9d132d1cb" //"2910395f83d512d5ba280cb3534117ae"
        
        /*
         ts - a timestamp (or other long string which can change on a request-by-request basis)
         hash - a md5 digest of the ts parameter, your private key and your public key (e.g. md5(ts+privateKey+publicKey)
         */
        
        let str = "\(getTSParameter())\(privateKey)\(publicKey)"
        
        //hash = str.utf8.md5
        
        return hash
    }
    
    class func getTSParameter() -> String {
        
        let timeStamp = NSDate().timeIntervalSince1970
        
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
