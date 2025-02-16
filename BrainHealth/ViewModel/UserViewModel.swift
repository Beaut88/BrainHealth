//
//  UserViewModel.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//
import Foundation

class UserViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var physicalHealth: Double = 0
    @Published var emotionalHealth: Double = 0
    @Published var cognition: Double = 0
    
    private let userDefaults = UserDefaults.standard
    private let userNameKey = "userName"
    private let physicalHealthKey = "physicalHealth"
    private let emotionalHealthKey = "emotionalHealth"
    private let cognitionKey = "cognition"
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        userName = userDefaults.string(forKey: userNameKey) ?? ""
        physicalHealth = userDefaults.double(forKey: physicalHealthKey)
        emotionalHealth = userDefaults.double(forKey: emotionalHealthKey)
        cognition = userDefaults.double(forKey: cognitionKey)
    }
    
    func saveUserName(_ name: String) {
        userDefaults.set(name, forKey: userNameKey)
        userName = name
        
        // Setting initial sample values for health metrics
        // In a real app, these would come from user input or assessments
        userDefaults.set(75.0, forKey: physicalHealthKey)
        userDefaults.set(68.0, forKey: emotionalHealthKey)
        userDefaults.set(82.0, forKey: cognitionKey)
        
        physicalHealth = 75.0
        emotionalHealth = 68.0
        cognition = 82.0
    }
    
    func calculateAverageHealth() -> Double {
        return (physicalHealth + emotionalHealth + cognition) / 3.0
    }
}
