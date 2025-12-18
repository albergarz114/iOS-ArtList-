//
//  ArtCard.swift .swift
//  ArtList
//
//  Created by Alberto Garza on 08.12.25.
//

import Foundation
import SwiftUI
import SwiftData


// NOTE: I replaced AsyncImage and placeholder to CachedAsyncImage (just FYI)
struct APIArtCard: View {
    
    let artwork: Artworks
    let onSave: () -> Void
    
    var body: some View {
        
        VStack {
            CachedAsyncImage(urlString: artwork.image ?? "No Image")
                .frame(height: 200)
                .cornerRadius(10)
            
            Text(artwork.title ?? "")
                .font(.headline)
                .padding()
            
            Button("Save") {
                onSave()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
}
    


struct SavedArtCard: View {
        
        let savedArts: SavedArts
        let onUpdate: (() -> Void)?
        let onDelete: (() -> Void)?
        
        var body: some View {
            
            VStack {
                
                CachedAsyncImage(urlString: savedArts.image ?? "No Image")
                    .frame(height: 200)
                    .cornerRadius(10)
                
                Text(savedArts.title ?? "Unknown Title")
                    .font(.headline)
                    .padding()
                
                if let onUpdate = onUpdate {
                    VStack {
                        Button("Update") {
                            onUpdate()
                        }
                    }
                    .background(Color.black)
                    .cornerRadius(10)
                    .buttonStyle(.bordered)
                    .font(.caption)
                    .tint(.blue)
                }
                
                if let onDelete = onDelete {
                    VStack {
                        Button("Delete") {
                            onDelete()
                        }
                    }
                    .background(Color.black)
                    .cornerRadius(10)
                    .buttonStyle(.bordered)
                    .font(.caption)
                    .tint(.blue)
                }
            }
            .background(Color.indigo.opacity(0.3))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
    }

