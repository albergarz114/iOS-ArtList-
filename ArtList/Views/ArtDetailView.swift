//
//  ArtDetailView.swift
//  ArtList
//
//  Created by Alberto Garza on 06.12.25.
//

import SwiftUI

struct ArtDetailView: View {
    
    @Environment(ArtsModel.self) var model
    
    var body: some View {
        
        let artwork = model.selectedArt
        
            
            HStack {
                VStack {
                    Text("Art Feed")
                    
                    AsyncImage(url: URL(string: artwork?.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(artwork?.title ?? "No Title")
                        .font(.largeTitle)
                        .bold()
                }
            }
        
    }
}

#Preview {
    ArtDetailView()
}
