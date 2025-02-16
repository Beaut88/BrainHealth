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
                        Color(red: 0.9, green: 0.95, blue: 1.0),
                        Color(red: 0.85, green: 0.95, blue: 0.9)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Text("Brain Health")
                        .font(.title2)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    let averageHealth = viewModel.calculateAverageHealth()
                    
                    Text(averageHealth >= 70 ?
                        "Nice Work! Your brain health is better than others" :
                        "Keep up the effort taking care of your brain, it can be better!")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Text("Let's remember to take care of our brain health... A strong mind is key to a healthy life")
                        .font(.custom("Comic Sans MS", size: 20))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Spacer()
                    
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
