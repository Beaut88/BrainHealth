//
//  FirstScreenView.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//

import SwiftUI

struct FirstScreenView: View {
    let userName: String
    @StateObject private var viewModel = UserViewModel()
    @State private var navigateToSecondScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.98, green: 0.92, blue: 0.87),    // Soft cream
                        Color(red: 0.97, green: 0.85, blue: 0.82),    // Delicate pink
                        Color(red: 0.95, green: 0.80, blue: 0.75),    // Light peach
                        Color(red: 0.92, green: 0.75, blue: 0.80),    // Muted rose
                        Color(red: 0.10, green: 0.15, blue: 0.35)     // Dark navy
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                            
                VStack(spacing: 25) {
                    Text("Brain Health")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    let averageHealth = viewModel.calculateAverageHealth()
                    
                    Text(averageHealth >= 70 ?
                        "Nice Work! Your brain health is better than others" :
                        "Keep up the effort taking care of your brain, it can be better!")
                        .font(.custom("Noteworthy-Bold", size: 30))
                        .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.2))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)  // Allows text to wrap properly
                        .padding()
                        .frame(maxWidth: .infinity)  // Ensures text takes available width
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    Text("Let's remember to take care of our brain's health. A strong mind is key to a healthy life!")
                       .font(.custom("Noteworthy", size: 20))
                       .foregroundColor(Color.black)
                       .multilineTextAlignment(.center)
                       .fixedSize(horizontal: false, vertical: true)
                       .padding()
                       .frame(maxWidth: .infinity)  // Uses available width
                       .background(Color.white)
                       .cornerRadius(15)
                       .padding(.horizontal, 24)
                    Spacer()
                    
                    Image("brain_img") // Reference to the SVG
                           .resizable()
                           .scaledToFit()
                           .frame(width: 200, height: 200)
                           .opacity(0.8)
                    
                    NavigationLink(destination: SecondScreenView()) {
                        Text("Mental Fitness Tracker")
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.96, green: 0.93, blue: 0.85)) // Beige color
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(radius: 3)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}
