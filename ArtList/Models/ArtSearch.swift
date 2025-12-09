//
//  ArtSearch.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//

import Foundation

struct APIObject: Decodable {
    
    var available: Int?
    var offset: Int?
    var number: Int?
    var artworks: [Artworks] = []
}

struct Artworks: Decodable, Identifiable {
    
    var id: Int?
    var title: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
    }
}
