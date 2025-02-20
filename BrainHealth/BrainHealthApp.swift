//
//  BrainHealthApp.swift
//  BrainHealth
//
//  Created by Nachicha Wongapichart on 16/02/2025.
//

import SwiftUI

@main
struct BrainHealthApp: App {
    @State private var showSecondScreen = false
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView(showSecondScreen: $showSecondScreen)
            }
        }
    }
}
