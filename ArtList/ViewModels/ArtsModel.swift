//
//  ArtsModel.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//

import Foundation
import SwiftUI


@Observable
class ArtsModel {
    
    var artworks: [Artworks] = []
    var service = DataService()
    var selectedArt: Artworks?
    
    func fetchArts(query: String?, origin: String?, material: String?, earliest_start_date: Int?) {
        Task {
           artworks = await service.artSearch(query: query, origin: origin, material: material, earliest_start_date: earliest_start_date)
        }
    }

}
