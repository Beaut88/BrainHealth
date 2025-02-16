//
//  ActivityViewModel.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//

import Foundation

class ActivityViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    private let userDefaults = UserDefaults.standard
    private let activitiesKey = "activities"
    
    let predefinedActivities: [Activity] = [
        // Physical Activities
        Activity(name: "30-minute walk", category: .physical),
        Activity(name: "Stretching exercises", category: .physical),
        Activity(name: "Dancing", category: .physical),
        Activity(name: "Yoga session", category: .physical),
        
        // Emotional Activities
        Activity(name: "Meditation", category: .emotional),
        Activity(name: "Journaling", category: .emotional),
        Activity(name: "Social connection", category: .emotional),
        Activity(name: "Gratitude practice", category: .emotional),
        
        // Cognition Activities
        Activity(name: "Puzzle solving", category: .cognition),
        Activity(name: "Reading", category: .cognition),
        Activity(name: "Memory games", category: .cognition),
        Activity(name: "Learning new skill", category: .cognition)
    ]
    
    init() {
        loadActivities()
    }
    
    func loadActivities() {
        if let data = userDefaults.data(forKey: activitiesKey),
           let decodedActivities = try? JSONDecoder().decode([Activity].self, from: data) {
            activities = decodedActivities
        } else {
            // Initialize with sample completed activities for the past week
            generateSampleWeekData()
        }
    }
    
    func saveActivities() {
        if let encoded = try? JSONEncoder().encode(activities) {
            userDefaults.set(encoded, forKey: activitiesKey)
        }
    }
    
    func generateSampleWeekData() {
        let calendar = Calendar.current
        let today = Date()
        
        for daysAgo in 0...6 {
            if let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) {
                // Add 2-3 random activities per day
                for _ in 0...2 {
                    let randomActivity = predefinedActivities.randomElement()!
                    let activity = Activity(
                        name: randomActivity.name,
                        category: randomActivity.category,
                        date: date,
                        completed: Bool.random()
                    )
                    activities.append(activity)
                }
            }
        }
        saveActivities()
    }
    
    func calculateWeeklyAverage(for category: ActivityCategory) -> Double {
        let calendar = Calendar.current
        let today = Date()
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: today)!
        
        let categoryActivities = activities.filter { activity in
            activity.category == category &&
            activity.date >= weekAgo &&
            activity.date <= today
        }
        
        let completedCount = categoryActivities.filter { $0.completed }.count
        let totalCount = categoryActivities.count
        
        return totalCount > 0 ? (Double(completedCount) / Double(totalCount)) * 100 : 0
    }
}
