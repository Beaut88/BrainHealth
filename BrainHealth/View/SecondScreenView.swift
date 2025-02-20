//
//  SecondScreenView.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//
import SwiftUI

struct SecondScreenView: View {
    @StateObject private var viewModel = ActivityViewModel()
    @State private var showingSummary = false
    @Binding var showSecondScreen: Bool
    
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
                Spacer()
                Text("Mental Fitness Tracker")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                Text("Pillars of a healthy mind")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.4, green: 0.8, blue: 0.4))
                    .padding(.top, 10)
                
                HStack(spacing: 20) {
                                    ForEach([ActivityCategory.physical, .emotional, .cognition]) { category in
                                        NavigationLink {
                                            ActivityDetailsView(viewModel: viewModel,category: category) // Pass viewModel here
                                        } label: {
                                            VStack {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color(red: 0.8, green: 0.9, blue: 1.0))
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
                
                Spacer()
                Button(action: {
                                   showingSummary = true
                               }) {
                                   Text("Finish")
                                       .font(.headline)
                                       .foregroundColor(.white)
                                       .frame(width: 200, height: 50)
                                       .background(
                                           RoundedRectangle(cornerRadius: 25)
                                               .fill(Color.green)
                                               .shadow(radius: 5)
                                       )
                               }
                               .padding(.bottom, 30)
                
            }
        }
        .onAppear {
                    if viewModel.checkAndHandleWeeklyReset() {
                        showingSummary = true
                    }
                }
                .navigationDestination(isPresented: $showingSummary) {
                    SummaryView(
                        viewModel: viewModel,
                        showSecondScreen: $showSecondScreen,
                        isAutoReset: true
                    )
                }
    }
}
