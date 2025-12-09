//
//  ArtRepository.swift
//  ArtList
//
//  Created by Alberto Garza on 08.12.25.
//

import Foundation
import SwiftUI
import SwiftData


@MainActor
final class ArtRepository {
    
    private let modelContext: ModelContext
    
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    
    // Create
    func saveArt(_ artworks: Artworks) {
        let savedArt = SavedArts(from: artworks)
        modelContext.insert(savedArt)
        savedContext()
    }
    
    
    // Read
    func fetchAllSavedArts() -> [SavedArts] {
        let descriptor = FetchDescriptor<SavedArts>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    
    // Update
    func updateArts(_ artworks: SavedArts, newTitle: String? = nil) {
        if let newTitle = newTitle {
            artworks.title = newTitle
        }
        savedContext()
    }
    
    
    // Update with start prefix
    func starArts(_ artworks: SavedArts) {
        artworks.title = "⭐\(artworks.title ?? "No Title")"
        savedContext()
    }
    
    
    // Delete
    func deleteArts(_ artworks: SavedArts) {
        modelContext.delete(artworks)
        savedContext()
    }
    
    
    // Delete all
    func deleteAllArts() {
        let allArts = fetchAllSavedArts()
        for art in allArts {
            modelContext.delete(art)
        }
        savedContext()
    }
    
    
    private func savedContext() {
        try? modelContext.save()
    }
}
