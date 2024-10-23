//
//  Habit.swift
//  Habits
//
//  Created by Bibek Bhujel on 22/10/2024.
//

import Foundation


// every time you add a habit
// you are actually adding a new habit

struct Habit: Identifiable{
    let id: Int
    let habitTitle: String
    let description: String
    let type: String
    let habitGoal: String
    let dailyCount: Int
    let dailyCountUnit: String
}
