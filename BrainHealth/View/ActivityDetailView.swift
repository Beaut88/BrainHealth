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
    @State private var showingAddActivity = false
    @State private var newActivityName = ""
    
    var filteredActivities: [Activity] {
        viewModel.activities.filter { $0.category == category }
    }
    
    private func deleteActivity(_ activity: Activity) {
         viewModel.deleteActivity(activity)
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
                                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                Button(role: .destructive) {
                                                    deleteActivity(activity)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                    }
                                }
                                .listStyle(PlainListStyle())
            }
            
            // Add Activity Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddActivity = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.green)
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 3)
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 30)
                }
            }
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivitySheet(
                category: category,
                viewModel: viewModel,
                isPresented: $showingAddActivity
            )
        }
    }
}
