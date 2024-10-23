//
//  AddNewHabit.swift
//  Habits
//
//  Created by Bibek Bhujel on 22/10/2024.
//

import SwiftUI

struct AddNewHabit: View {
    let habitGoals = ["Build a habit", "Break a habit"]
    let habitTypes = ["Healthy Habits", "Unhealthy Habits", "Body", "Mind", "Happiness", "Commitment", "Productivity", "Custom Habit"]
    
    let dailyGoalUnits = ["count", "Custom Unit"]
    
    @State private var selectedName = ""
    @State private var selectedDescription = ""
    @State private var selectedGoal = "Build a habit"
    @State private var habitType = "Healthy Habits"
    @State private var dailyGoalUnit = "count"
    
    
    @State private var showMore = false
    var detailsButtonText: String {
        showMore ? "show less": "show more"
    }
    
    var customHabitTypeSelected: Bool {
        return habitType == "Custom Habit"
    }
    
    @State private var customHabitType = ""
    // while saving the habit , if the customhabit is selected then send this custom type otherwise just habit type
    
    var customGoalUnitSelected: Bool {
        return dailyGoalUnit == "Custom Unit"
    }
    
    @State private var customDailyGoalUnit = "" // if the custom unit is selected then send this custom type otherwose just daily goal unit when you save the data

    
    @Environment(\.dismiss) var dismiss
    
    @State private var dailyCount = 0
    
    var body: some View {
        NavigationStack {
                ZStack {
                    Color(.sheetBackgroundColor).ignoresSafeArea()
                    Form {
                        Section {
                            TextField("E.g., Take a walk", text: $selectedName)
                                .cursorStyle()
                                
                        }header: {
                            Text("name")
                        }.sectionColorStyle()
                        
                        
                        Section {
                            Picker("I want to", selection: $selectedGoal) {
                                ForEach(habitGoals, id: \.self) { goal in
                                    Text(goal)
                                }
                            }.pickerStyle(.navigationLink)
                           
                            if showMore {
                                TextField("Description", text: $selectedDescription, axis: .vertical)
                                    .cursorStyle()
                            }
                            
                        }header: {
                            HStack {
                                Text("details")
                                Spacer()
                                Button {
                                   // show description label
                                    showMore.toggle()
                                }label: {
                                    Text(detailsButtonText)
                                        .font(.caption)
                                }
                            }
                        }.sectionColorStyle()
                        

                        Section {
                            Picker("Select Type", selection: $habitType) {
                                ForEach(habitTypes, id: \.self) { goal in
                                    Text(goal)
                                }
                            }.pickerStyle(.navigationLink)
                            
                            if customHabitTypeSelected {
                                TextField("Custom habit", text: $customHabitType, axis: .vertical)
                                    .cursorStyle()
                            }
                        }header: {
                             Text("Type")
                        }.sectionColorStyle()
                        
                        Section {
                            HStack {
                                TextField("",value: $dailyCount, formatter: NumberFormatter())
                                    .cursorStyle()
                                Spacer()
                                Stepper("", onIncrement: {
                                    incrementDailyCount()
                                }, onDecrement: {
                                    decrementDailyCount()
                                })
                            }
                            
                            Picker("Unit", selection: $dailyGoalUnit) {
                                ForEach(dailyGoalUnits, id: \.self) { goal in
                                    Text(goal)
                                }
                            }.pickerStyle(.navigationLink)
                            
                            if customGoalUnitSelected {
                                TextField("Custom Unit", text: $customDailyGoalUnit, axis: .vertical)
                                    .cursorStyle()
                            }
                        }header: {
                            Text("my daily goal")
                        }.sectionColorStyle()
                        
                    }.scrollContentBackground(.hidden)
            }
            .navigationTitle("Add new habit")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func incrementDailyCount() {
        dailyCount += 1
    }
    
    func decrementDailyCount() {
        dailyCount -= 1
        if dailyCount < 0 {
            dailyCount = 0
        }
    }
}

struct CursorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.autocorrectionDisabled()
            .tint(Color.itemsBackgroundColor)
    }
}


extension View {
    func cursorStyle() -> some View {
        modifier(CursorStyle())
    }
}

struct SectionColor: ViewModifier {
    func body(content: Content) -> some View {
        content.listRowBackground(Color.sectionBackgroundColor)
    }
}


extension View {
    func sectionColorStyle() -> some View {
        modifier(SectionColor())
    }
}


#Preview {
    AddNewHabit()
}
