//
//  Hero.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

struct Hero: Codable {
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail?
    var isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? .zero
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        
        self.thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail) ?? nil

        self.isFavorite = false
    }
    
}

struct Thumbnail: Codable {
    let path: String
    let imageType: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageType = "extension"
    }
}

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
