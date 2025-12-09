//
//  ContentView.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(ArtsModel.self) var model
    
    var body: some View {
        
        @Bindable var model = model
            
            TabView {
                // Tab 1: Grid View
                NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(model.artworks) { artwork in
                                Button {
                                    model.selectedArt = artwork
                                } label: {
                                    VStack {
                                        AsyncImage(url: URL(string: artwork.image ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(10)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(height: 150)
                                        }
                                        .frame(height: 150)
                                        
                                        Text(artwork.title ?? "Unknown Title")
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Gallery")
                }
                .tabItem {
                    Label("Gallery", systemImage: "square.grid.2x2")
                }
                
                // Tab 2: List View
                NavigationStack {
                    ListView()
                        .navigationTitle("List")
                }
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            }
        
            .sheet(item: $model.selectedArt) { artwork in
                ArtDetailView()
            }
            .onAppear {
                model.fetchArts(query: "landscape", origin: "Italy", material: "ceramic", earliest_start_date: 1600)
            }
        }
    }


#Preview {
    HomeView()
        .environment(ArtsModel())
}
