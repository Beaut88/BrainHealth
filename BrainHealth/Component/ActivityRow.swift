//
//  ActivityRow.swift
//  BrainHealth
//
//  Created by Warit Karnbunjob on 20/2/2568 BE.
//

import SwiftUI

struct ActivityRow: View {
    let activity: Activity
    @ObservedObject var viewModel: ActivityViewModel
    @State private var isCompleted: Bool
    
    init(activity: Activity, viewModel: ActivityViewModel) {
        self.activity = activity
        self.viewModel = viewModel
        _isCompleted = State(initialValue: activity.completed)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(activity.name)
                    .font(.headline)
                
                Text(formatDate(activity.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Divider line
            Rectangle()
                .frame(width: 1, height: 30)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.horizontal, 8)
            
            // Status Toggle Button
            Button(action: {
                toggleStatus()
            }) {
                Text(isCompleted ? "Completed" : "Pending")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(isCompleted ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                    )
                    .foregroundColor(isCompleted ? .green : .orange)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func toggleStatus() {
            isCompleted.toggle()
            if let index = viewModel.activities.firstIndex(where: { $0.id == activity.id }) {
                var updatedActivity = activity
                updatedActivity.completed = isCompleted
                updatedActivity.completionDate = isCompleted ? Date() : nil
                viewModel.activities[index] = updatedActivity
                viewModel.saveActivities()
                // Force view update
                viewModel.objectWillChange.send()
            }
        }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
