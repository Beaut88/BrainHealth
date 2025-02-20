//
//  SummaryView.swift
//  BrainHealth
//
//  Created by Warit Karnbunjob on 20/2/2568 BE.
//
import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: ActivityViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingFirstScreen = false
    @Binding var showSecondScreen: Bool
    let isAutoReset: Bool
    
    var overallCompletion: Double {
        let completedCount = viewModel.activities.filter { $0.completed }.count
        let totalCount = viewModel.activities.count
        return totalCount > 0 ? (Double(completedCount) / Double(totalCount)) * 100 : 0
    }
    
    var categoryCompletions: [(category: ActivityCategory, completion: Double)] {
        ActivityCategory.allCases.map { category in
            (category, viewModel.calculateWeeklyAverage(for: category))
        }
    }
    
    var body: some View {
        ZStack {
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
                Text("Your Progress Summary")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                // Overall completion circle
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0, to: overallCompletion / 100)
                        .stroke(overallCompletion >= 70 ? Color.green : Color.orange, lineWidth: 20)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text("\(Int(overallCompletion))%")
                            .font(.system(size: 40, weight: .bold))
                        Text("Complete")
                            .font(.headline)
                    }
                }
                
                // Feedback message
                Text(overallCompletion >= 70 ? "Well Done! 🎉" : "You Can Do Better! 💪")
                    .font(.title2)
                    .foregroundColor(overallCompletion >= 70 ? .green : .brown)
                    .padding()
                
                // Category breakdown
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(categoryCompletions, id: \.category) { item in
                        VStack(alignment: .leading) {
                            Text(item.category.rawValue)
                                .font(.headline)
                            
                            HStack {
                                Rectangle()
                                    .fill(item.completion >= 70 ? Color.green : Color.orange)
                                    .frame(width: CGFloat(item.completion) * 2, height: 20)
                                    .cornerRadius(10)
                                
                                Text("\(Int(item.completion))%")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding()
                
                Button(action: {
                    resetAndReturn()
                }) {
                    Text("Let's Start Again")
                       .font(.headline)
                       .foregroundColor(.brown)
                       .frame(width: 200, height: 50)
                       .background(
                           RoundedRectangle(cornerRadius: 25)
                               .fill(Color(red: 0.96, green: 0.87, blue: 0.70))  // Warm beige
                               .shadow(radius: 5)
                        )
                }
                .padding(.top, 30)
                
                if isAutoReset {
                    Text("Weekly progress reset occurs every Sunday")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func resetAndReturn() {
        viewModel.resetWithPredefinedActivities()
        showSecondScreen = false
        dismiss()
    }
}
