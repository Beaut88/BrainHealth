//
//  WelcomView.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var newUserName: String = ""
    @State private var showSubmitButton: Bool = true
    @State private var navigateToFirstScreen: Bool = false
    @Binding var showSecondScreen: Bool
    
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
                    
                    
                    
                    Text(viewModel.userName.isEmpty ? "Hello there!" : "Hello, \(viewModel.userName)")
                        .font(.custom("Noteworthy-Bold", size: 40))
                        .padding(.top, 30)
                    
                    if viewModel.userName.isEmpty {
                        TextField("Enter your name", text: $newUserName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 50)
                        
                        if showSubmitButton {
                            Button(action: {
                                if !newUserName.isEmpty {
                                    viewModel.saveUserName(newUserName)
                                    showSubmitButton = false
                                    // Add a small delay before navigation
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        navigateToFirstScreen = true
                                    }
                                }
                            }) {
                                Text("Submit")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    if !viewModel.userName.isEmpty {
                       Text("Hope you had a great day, let's conserve ur precious brain")
                           .font(.custom("Noteworthy-Bold", size: 35))  // Changed to Noteworthy-Bold
                           .multilineTextAlignment(.center)
                           .frame(maxWidth: .infinity)
                           .padding(.vertical, 100)
                           .onAppear {
                               DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                   navigateToFirstScreen = true
                               }
                           }
                    }
                    
                    Spacer()
                }
                
//                NavigationLink(
//                    destination: FirstScreenView(userName: viewModel.userName),
//                    isActive: $navigateToFirstScreen
//                ) {
//                    EmptyView()
//                }
            }
        }
    }
}
