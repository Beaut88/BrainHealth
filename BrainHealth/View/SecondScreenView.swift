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
                   Color(red: 0.95, green: 0.90, blue: 1.0),    // Soft lavender
                   Color(red: 0.90, green: 0.92, blue: 1.0),    // Light periwinkle
                   Color(red: 0.85, green: 0.90, blue: 0.98)    // Gentle sky blue
               ]),
               startPoint: .topLeading,
               endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
               Spacer()
               Text("Mental Fitness Tracker")
                   .font(.custom("Noteworthy-Bold", size: 34))
                   .padding(.top, 50)
                
                Text("Pillars of a healthy brain")
                   .font(.custom("Noteworthy-Bold", size: 24))  // Changed to Noteworthy-Bold
                   .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.2))  // Cherry red
                   .padding(.top, 10)
                HStack(spacing: 20) {
                                    ForEach([ActivityCategory.physical, .emotional, .cognition]) { category in
                                        NavigationLink {
                                            ActivityDetailsView(viewModel: viewModel,category: category) // Pass viewModel here
                                        } label: {
                                            VStack {
                                                ZStack {
                                                    Circle()
                                                        .fill(
                                                                               LinearGradient(
                                                                                   gradient: Gradient(colors: [
                                                                                       Color(red: 0.4, green: 0.2, blue: 0.6),  // Medium purple
                                                                                       Color(red: 0.3, green: 0.1, blue: 0.5),  // Deeper purple
                                                                                       Color(red: 0.2, green: 0.0, blue: 0.4)   // Dark purple
                                                                                   ]),
                                                                                   startPoint: .topLeading,
                                                                                   endPoint: .bottomTrailing
                                                                               )
                                                                           )
                                                                           .frame(width: 100, height: 100)
                                                                   
                                                                   VStack {
                                                                       Text(category.rawValue)
                                                                           .font(.custom("Noteworthy-Bold", size: 14))
                                                                           .foregroundColor(.white)  // Changed to white for better contrast
                                                                       Text("\(Int(viewModel.calculateWeeklyAverage(for: category)))%")
                                                                           .font(.custom("Noteworthy-Bold", size: 20))
                                                                           .foregroundColor(.white)
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
                                               .fill(Color.red)
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
