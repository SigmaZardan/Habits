//
//  AddNewHabit.swift
//  Habits
//
//  Created by Bibek Bhujel on 22/10/2024.
//

import SwiftUI

struct AddNewHabit: View {
    let habitGoals = ["Build a habit", "Break a habit"]
    let habitTypes = ["Healthy Habits", "Unhealthy Habits", "Body", "Mind", "Happiness", "Commitment", "Productivity", "Custom Type"]
    
    let dailyGoalUnits = ["count", "Custom Unit"]
    
    @State private var selectedTitle = ""
    @State private var selectedDescription = ""
    @State private var selectedGoal = "Build a habit"
    @State private var habitType = "Healthy Habits"
    @State private var dailyGoalUnit = "count"
    
    
    @State private var showMore = false
    var detailsButtonText: String {
        showMore ? "show less": "show more"
    }
    
    var customHabitTypeSelected: Bool {
        return habitType == "Custom Type"
    }
    
    @State private var customHabitType = ""
  
    
    var customCountUnitSelected: Bool {
        return dailyGoalUnit == "Custom Unit"
    }
    
    @State private var customDailyCountUnit = ""

    
    @Environment(\.dismiss) var dismiss
    
    @State private var dailyCount = 0
    
    @State private var showTitleError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    @FocusState private var isFocused: Bool
    
    let habits: Habits
    
    var body: some View {
        NavigationStack {
                ZStack {
                    Color(.sheetBackgroundColor).ignoresSafeArea()
                    VStack {
                        Form {
                            Section {
                                TextField("E.g., Take a walk", text: $selectedTitle)
                                    .cursorStyle()
                                    .textFieldStyle()
                                    .focused($isFocused)
                                
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
                                            .focused($isFocused)
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
                                        .textFieldStyle()
                                        .focused($isFocused)
                                }
                            }header: {
                                Text("Type")
                            }.sectionColorStyle()
                            
                            Section {
                                HStack {
                                    TextField("",value: $dailyCount, formatter: NumberFormatter())
                                        .cursorStyle()
                                        .textFieldStyle()
                                        .keyboardType(.numberPad)
                                        .focused($isFocused)
                                    
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
                                
                                if customCountUnitSelected {
                                    TextField("Custom Unit", text: $customDailyCountUnit, axis: .vertical)
                                        .cursorStyle()
                                        .textFieldStyle()
                                        .focused($isFocused)
                                }
                            }header: {
                                Text("my daily goal")
                            }.sectionColorStyle()
                            
                        }.scrollContentBackground(.hidden)
                        
                        
                            Button {
                                // add habit
                                addHabit()
                                
                                
                            }label: {
                                Text("Add habit")
                                    .font(.title3.bold())
                                    .padding()
                            }
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(.itemsBackgroundColor)
                            .foregroundStyle(.black)
                            .clipShape(.rect(cornerRadius: 12))
                            .padding()
                            
                        }
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
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isFocused = false
                    }label: {
                        Text("Done")
                    }
                }
            }
            .alert(errorTitle, isPresented: $showTitleError) {
                Button("OK") {}
            }message: {
                Text(errorMessage)
            }
        }
    }
    
    
    func addHabit() {
        guard isNotEmpty(input: selectedTitle) else {
            inputError(title: "Empty Title", message: "Title cannot be empty!")
            return
        }
        
        
        if customHabitTypeSelected {
            guard isNotEmpty(input: customHabitType) else {
                inputError(title: "Empty Custom Habit Type", message: "Habit type cannot be empty!")
                return
            }
        }
        
        if customCountUnitSelected {
            guard isNotEmpty(input: customDailyCountUnit) else {
                inputError(title: "Empty Custom Count Unit", message: "Custom count unit cannot be empty!")
                return
            }
        }
        
       
        let habit = Habit(habitTitle: selectedTitle, description: selectedDescription, type: customHabitTypeSelected ? customHabitType : habitType, habitGoal: selectedGoal, dailyCount: dailyCount, dailyCountUnit: customCountUnitSelected ? customDailyCountUnit : customDailyCountUnit)
       
        
        habits.habits.append(habit)
        dismiss()
    }
    
    func inputError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showTitleError = true
    }
    
    
    
    func isNotEmpty(input: String) -> Bool {
        return !input.isEmpty
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


struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.textInputAutocapitalization(.never)
    }
}


extension View {
    func cursorStyle() -> some View {
        modifier(CursorStyle())
    }
    
    func textFieldStyle() -> some View {
        modifier(TextFieldStyle())
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
    AddNewHabit(habits: Habits())
}
