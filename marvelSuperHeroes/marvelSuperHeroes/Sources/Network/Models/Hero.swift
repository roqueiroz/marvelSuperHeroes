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
    let imageUrl: String
    private let thumbnail: Thumbnail
    
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
        self.isFavorite = false
        
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail) ?? Thumbnail()

        imageUrl = "\(thumbnail.path).\(thumbnail.imageType)"
    
    }
    
    init(id: Int, name: String, description: String, imageUrl: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
        
        self.thumbnail = Thumbnail()
    }
    
}

struct Thumbnail: Codable {
    
    let path: String
    let imageType: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageType = "extension"
    }
    
    init() {
        self.path = ""
        self.imageType = ""
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
        self.imageType = try container.decodeIfPresent(String.self, forKey: .imageType) ?? ""
    
    }

}

