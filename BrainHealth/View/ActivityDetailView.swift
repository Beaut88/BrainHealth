//
//  ActivityDetailView.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//
import SwiftUI

struct ActivityDetailsView: View {
    @StateObject private var viewModel = ActivityViewModel()
    
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
            
            VStack {
                Text("Activity Log")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                List {
                    ForEach(ActivityCategory.allCases, id: \.self) { category in
                        Section(header: Text(category.rawValue)) {
                            ForEach(viewModel.activities.filter { $0.category == category }) { activity in
                                HStack {
                                    Text(activity.name)
                                    Spacer()
                                    Text(activity.completed ? "✓" : "○")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

