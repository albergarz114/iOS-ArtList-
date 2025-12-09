//
//  OnboardingDetailView.swift
//  ArtList
//
//  Created by Alberto Garza on 06.12.25.
//

import SwiftUI

struct OnboardingDetailView: View {
    
    var headline: String
    var subheadline: String
    var buttonAction: () -> Void
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.12, green: 0.10, blue: 0.16),
                    Color(red: 0.18, green: 0.15, blue: 0.22),
                    Color(red: 0.25, green: 0.20, blue: 0.28)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text(headline)
                    .font(Font.system(size: 22))
                    .bold()
                    .foregroundStyle(Color(.white))
                Text(subheadline)
                    .font(Font.system(size: 16))
                    .bold()
                    .foregroundStyle(Color(.white))
                    .padding(.top, 10)
                Spacer()
                Spacer()
                Button {
                    buttonAction()
                } label: {
                    ZStack {
                        Text("Get Started")
                            .font(Font.system(size: 16))
                            .bold()
                            .foregroundStyle(Color(.white))
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 150, height: 50)
                            .foregroundStyle(Color(.black))
                            .opacity(0.3)
                    }
                }
                Spacer()
                }
            }
            
        }
    }


#Preview {
    OnboardingDetailView(headline: "Welcome to our App!", subheadline: "Discover the beauty of Natural Arts", buttonAction: {})
}
