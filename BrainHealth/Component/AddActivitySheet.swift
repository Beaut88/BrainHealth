//
//  AddActivitySheet.swift
//  BrainHealth
//
//  Created by Warit Karnbunjob on 20/2/2568 BE.
//

import SwiftUI

struct AddActivitySheet: View {
    let category: ActivityCategory
    @ObservedObject var viewModel: ActivityViewModel
    @Binding var isPresented: Bool
    @State private var activityName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New \(category.rawValue) Activity")) {
                    TextField("Activity Name", text: $activityName)
                }
            }
            .navigationTitle("Add Activity")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Add") {
                    addActivity()
                }
                .disabled(activityName.trimmingCharacters(in: .whitespaces).isEmpty)
            )
        }
    }
    
    private func addActivity() {
        let newActivity = Activity(
            name: activityName.trimmingCharacters(in: .whitespaces),
            category: category,
            date: Date(),
            completed: false
        )
        viewModel.activities.append(newActivity)
        viewModel.saveActivities()
        isPresented = false
    }
}
