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
                
                VStack(spacing: 20) {
                    Text("Brain Health")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    Text(viewModel.userName.isEmpty ? "Hello there!" : "Hello \(viewModel.userName)")
                        .font(.title2)
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
                        Text("How are you?")
                            .font(.title3)
                            .padding(.top, 10)
                            .onAppear {
                                // Navigate to first screen after showing "How are you?"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    navigateToFirstScreen = true
                                }
                            }
                    }
                    
                    Spacer()
                }
                
                NavigationLink(
                    destination: FirstScreenView(userName: viewModel.userName),
                    isActive: $navigateToFirstScreen
                ) {
                    EmptyView()
                }
            }
        }
    }
}
