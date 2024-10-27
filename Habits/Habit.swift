//
//  Habit.swift
//  Habits
//
//  Created by Bibek Bhujel on 22/10/2024.
//

import Foundation


// every time you add a habit
// you are actually adding a new habit

struct Habit: Identifiable, Codable, Equatable{
    var id = UUID()
    let habitTitle: String
    let description: String
    let type: String
    let habitGoal: String
    let dailyCount: Int
    let dailyCountUnit: String
    var completionCount: Int = 0
}

@Observable
class Habits {
    var habits: [Habit] {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "HabitItems")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "HabitItems") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
                habits = decodedItems
                return
            }
        }
    
        habits = []
    }
}
