//
//  ActivityViewModel.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//
import Foundation

class ActivityViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var successfulActivities: [Activity] = []
    @Published var unsuccessfulActivities: [Activity] = []
    
    private let userDefaults = UserDefaults.standard
    private let activitiesKey = "activities"
    private let successfulActivitiesKey = "successfulActivities"
    private let unsuccessfulActivitiesKey = "unsuccessfulActivities"
    
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
        loadFromUserDefaults()
        if activities.isEmpty {
            generateSampleWeekData()
        }
        updateActivityLists()
    }
    
    private func loadFromUserDefaults() {
        if let data = userDefaults.data(forKey: activitiesKey),
           let decodedActivities = try? JSONDecoder().decode([Activity].self, from: data) {
            activities = decodedActivities
        }
    }
    
    func saveActivities() {
        if let encoded = try? JSONEncoder().encode(activities) {
            userDefaults.set(encoded, forKey: activitiesKey)
            updateActivityLists()
        }
    }
    
    private func updateActivityLists() {
        successfulActivities = activities.filter { $0.completed }
        unsuccessfulActivities = activities.filter { !$0.completed }
    }
    
    func markActivityAsCompleted(_ activity: Activity) {
        if let index = activities.firstIndex(where: { $0.id == activity.id }) {
            var updatedActivity = activity
            updatedActivity.completed = true
            updatedActivity.completionDate = Date()
            activities[index] = updatedActivity
            saveActivities()
        }
    }
    
    func generateSampleWeekData() {
        let calendar = Calendar.current
        let today = Date()
        
        activities = (0...6).flatMap { daysAgo -> [Activity] in
            guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) else {
                return []
            }
            
            return (0...2).map { _ in
                let randomActivity = predefinedActivities.randomElement()!
                let completed = Bool.random()
                return Activity(
                    name: randomActivity.name,
                    category: randomActivity.category,
                    date: date,
                    completed: completed,
                    completionDate: completed ? date : nil
                )
            }
        }
        
        saveActivities()
    }
    
    func calculateWeeklyAverage(for category: ActivityCategory) -> Double {
        let calendar = Calendar.current
        let today = Date()
        guard let weekAgo = calendar.date(byAdding: .day, value: -7, to: today) else {
            return 0
        }
        
        let categoryActivities = activities.filter { activity in
            activity.category == category &&
            activity.date >= weekAgo &&
            activity.date <= today
        }
        
        let completedCount = categoryActivities.filter { $0.completed }.count
        let totalCount = categoryActivities.count
        
        return totalCount > 0 ? (Double(completedCount) / Double(totalCount)) * 100 : 0
    }
    
    // Helper methods for activity statistics
    func getSuccessfulActivitiesCount(category: ActivityCategory? = nil) -> Int {
        if let category = category {
            return successfulActivities.filter { $0.category == category }.count
        }
        return successfulActivities.count
    }
    
    func getUnsuccessfulActivitiesCount(category: ActivityCategory? = nil) -> Int {
        if let category = category {
            return unsuccessfulActivities.filter { $0.category == category }.count
        }
        return unsuccessfulActivities.count
    }
}
