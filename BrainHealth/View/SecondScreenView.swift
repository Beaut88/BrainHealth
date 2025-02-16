//
//  SecondScreenView.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//
import SwiftUI

struct SecondScreenView: View {
    @StateObject private var viewModel = ActivityViewModel()
    @State private var navigateToActivityDetails = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.9, green: 0.95, blue: 1.0),
                    Color(red: 0.85, green: 0.95, blue: 0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Mental Fitness Tracker")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                Text("Pillars of a healthy mind")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.4, green: 0.8, blue: 0.4)) // Light green
                    .padding(.top, 10)
                
                HStack(spacing: 20) {
                    ForEach([ActivityCategory.physical, .emotional, .cognition]) { category in
                        Button(action: {
                            navigateToActivityDetails = true
                        }) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.8, green: 0.9, blue: 1.0)) // Light blue
                                        .frame(width: 100, height: 100)
                                    
                                    VStack {
                                        Text(category.rawValue)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                        Text("\(Int(viewModel.calculateWeeklyAverage(for: category)))%")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                
                NavigationLink(destination: ActivityDetailsView(), isActive: $navigateToActivityDetails) {
                    EmptyView()
                }
                
                Spacer()
            }
        }
    }
}

