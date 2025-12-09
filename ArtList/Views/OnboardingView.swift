//
//  OnboardingView.swift
//  ArtList
//
//  Created by Alberto Garza on 06.12.25.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(ArtsModel.self) var model
    @Environment(\.dismiss) var dismiss
    @State var selectedViewIndex = 0
    
    var body: some View {
        
        ZStack {
            
            if selectedViewIndex == 0 {
                Color(red: 0.12, green: 0.10, blue: 0.16)
                Color(red: 0.18, green: 0.15, blue: 0.22)
                Color(red: 0.25, green: 0.20, blue: 0.28)
            } else {
                Color(red: 0.12, green: 0.10, blue: 0.16)
                Color(red: 0.18, green: 0.15, blue: 0.22)
                Color(red: 0.25, green: 0.20, blue: 0.28)
            }
            
            TabView(selection: $selectedViewIndex) {
                OnboardingDetailView(headline: "Welcome to our App!", subheadline: "Discover the beauty of Natural Arts", buttonAction: {
                    
                    withAnimation {
                        selectedViewIndex = 1
                    }
                })
                .tag(0)
                .ignoresSafeArea()
                
                
                OnboardingDetailView(headline: "Enjoy the App!", subheadline: "Please give us a star rating", buttonAction: {
                    
                    dismiss()
                })
                .tag(1)
                .ignoresSafeArea()
            }
            
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 0 ? .white : .gray)
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 1 ? .white : .gray)
                    Spacer()
                }
                .padding(.bottom, 80)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
