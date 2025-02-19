//
//  ActivityDetailView.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//
import SwiftUI

struct ActivityDetailsView: View {
    @ObservedObject var viewModel: ActivityViewModel
    let category: ActivityCategory
    
    var filteredActivities: [Activity] {
        viewModel.activities.filter { $0.category == category }
    }
    
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
            
            VStack(spacing: 20) {
                Text("\(category.rawValue) Activities")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                // Status count cards
                HStack(spacing: 16) {
                    StatusCard(
                        title: "Completed",
                        count: filteredActivities.filter { $0.completed }.count,
                        color: .green
                    )
                    StatusCard(
                        title: "Pending",
                        count: filteredActivities.filter { !$0.completed }.count,
                        color: .orange
                    )
                }
                .padding(.horizontal)
                
                List {
                                   ForEach(filteredActivities) { activity in
                                       ActivityRow(activity: activity, viewModel: viewModel)
                                   }
                               }
                .listStyle(PlainListStyle())
            }
        }
    }
}
