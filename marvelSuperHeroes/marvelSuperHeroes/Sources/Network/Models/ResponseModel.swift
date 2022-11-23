//
//  ResponseModel.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 22/11/22.
//

import Foundation

struct Response: Codable {
    
    var code: Int
    var status: String
    var data: ResponseData
}

struct ResponseData: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Hero]
}
