//
//  ArtListApp.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//

import SwiftUI
import SwiftData

@main
struct ArtListApp: App {
    
    @State var model = ArtsModel()
    @AppStorage("onboarding") var needsOnboarding = true
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
            
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environment(model)
            }
        }
        .modelContainer(for: SavedArts.self)
    }
}
