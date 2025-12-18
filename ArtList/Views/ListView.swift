//
//  ListView.swift
//  ArtList
//
//  Created by Alberto Garza on 06.12.25.
//

// NOTE: Using ScrollView for saved items, List for API items to avoid swipe conflict

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(ArtsModel.self) var model
    @Environment(\.modelContext) private var modelContext
    @Query private var savedArts: [SavedArts]
    @State private var repository: ArtRepository?
    @State private var showSaved = false
    @State private var cacheStats = ""
    
    var body: some View {
        
        VStack {
            
            // Add cache stats display
            Text(cacheStats)
                .font(.caption)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            HStack {
                Button(showSaved ? "API" : "Saved Data") {
                    showSaved.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                // Add cache stats
                Button("Show Cache Stats") {
                    cacheStats = ImageCache.shared.getStats()
                }
                .buttonStyle(.bordered)
                .tint(Color.orange)
                
                // Add cache clear button
                Button("Clear Cache") {
                    ImageCache.shared.clearCache()
                }
                .buttonStyle(.bordered)
                .tint(.red)
                
                if showSaved && !savedArts.isEmpty {
                    Button("Clear All") {
                        repository?.deleteAllArts()
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
            }
            .padding()
            
            switch showSaved {
                // Use ScrollView for saved items (allows custom buttons)
            case true:
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],spacing: 16) {
                        ForEach(savedArts) { savedArt in
                            SavedArtCard(savedArts: savedArt, onUpdate: {
                                repository?.starArts(savedArt)
                            }, onDelete: {
                                repository?.deleteArts(savedArt)
                            })
                            .onTapGesture {
                                let artwork = Artworks(
                                    id: savedArt.id,
                                    title: savedArt.title,
                                    image: savedArt.image
                                )
                                model.selectedArt = artwork
                            }
                        }
                    }
                    .padding()
                }
            case false:
                // Use List for API items (standard behavior)
                List {
                    ForEach(model.artworks) { artwork in
                        APIArtCard(artwork: artwork) {
                            repository?.saveArt(artwork)
                        }
                        .onTapGesture {
                            model.selectedArt = artwork
                        }
                    }
                }
                .listStyle(.plain)
            }
                
            
        }
        .onAppear {
            if repository == nil {
                repository = ArtRepository(modelContext: modelContext)
            }
            
            // Load initial stats
            cacheStats = ImageCache.shared.getStats()
        }
    }
}

#Preview {
    ListView()
        .environment(ArtsModel())
}
