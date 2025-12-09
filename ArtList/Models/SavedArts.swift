//
//  SavedArts.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//


import SwiftUI
import SwiftData


@Model
final class SavedArts {
    var id: Int?
    var title: String?
    var image: String?
    
    init(id: Int? = nil, title: String? = nil, image: String? = nil) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    convenience init(from artworks: Artworks) {
        self.init(
            id: artworks.id,
            title: artworks.title,
            image: artworks.image
        )
    }
}
