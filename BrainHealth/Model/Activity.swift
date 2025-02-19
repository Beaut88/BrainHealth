//
//  Activity.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id: UUID
    let name: String
    let category: ActivityCategory
    let date: Date
    var completed: Bool
    var completionDate: Date?
    
    init(id: UUID = UUID(),
         name: String,
         category: ActivityCategory,
         date: Date = Date(),
         completed: Bool = false,
         completionDate: Date? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.date = date
        self.completed = completed
        self.completionDate = completionDate
    }
}

enum ActivityCategory: String, Codable, Identifiable, CaseIterable {
    case physical = "Physical"
    case emotional = "Emotional"
    case cognition = "Cognition"
    
    var id: String { self.rawValue }
}


extension ActivityCategory: Hashable {}
