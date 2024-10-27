//
//  DisplayHabit.swift
//  Habits
//
//  Created by Bibek Bhujel on 24/10/2024.
//

import SwiftUI

struct DisplayHabit: View {
    let habits: Habits
    
    @State private var count = 89
        let total = 100
    // the total can be total addition of the entire habits
    // same goes with the count
    // this will make sure the percentage in the big circular progress bar go as needed
    
    var overallDailyCount: Int {
        var overallDailyCount = 0
        for habit in habits.habits {
            overallDailyCount += habit.dailyCount
        }
        return overallDailyCount
    }
    
    var overallCompletionCount: Int {
        var overallCompletionCount = 0
        for habit in habits.habits {
            overallCompletionCount += habit.completionCount
        }
        return overallCompletionCount
    }
    
    
    @State private var animationAmountOverallProgress = 1.0
    @State private var animationAmountIndividualProgress = 1.0
    
    var body: some View {
            List {
                HStack {
                    CircularProgressView(count: overallCompletionCount, total: overallDailyCount, showPercent: true,backgroundLineStroke: 30.0, onTopProgressStroke: 31.0, checkMarkSize: 130, countTextSize: 80)
                        .scaleEffect(animationAmountOverallProgress)
                        .animation(.spring(duration: 0.25, bounce: 0.5), value: animationAmountOverallProgress)
                        .onTapGesture {
                            if count < total {
                                count += 1
                                animationAmountOverallProgress = 1.1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                   
                                    animationAmountOverallProgress = 1.0
                                }
                            }
                        }
                        
                        
                }.frame(maxWidth: .infinity, maxHeight:250)
                    .padding(50)

                    ForEach(habits.habits) {
                        habit in
                        HStack {
                            VStack(alignment:.leading){
                                Text(habit.habitTitle)
                                    .font(.title2.bold())
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                
                                Text("Goal: \(habit.dailyCount) \(habit.dailyCountUnit)")
                                
                            }.padding(.horizontal)
                            
                            Spacer()
                            
                            HStack {
                                IndividualProgressView(habit: habit, habits: habits)
                            }.frame(maxHeight: 70).padding()
                            
                        }.frame(maxWidth: .infinity)
                            .background(.lightDarkBackground)
                            .clipShape(.rect(cornerRadius:10))
                    }
                    .onDelete(perform: removeHabit)
                
        }.preferredColorScheme(.dark)
            .toolbar {
                EditButton()
            }
        
    }
    
    func removeHabit(at offsets: IndexSet) {
        habits.habits.remove(atOffsets: offsets)
    }
}

struct IndividualProgressView: View {
    let habit: Habit
    let habits: Habits
    @State private var animationAmountIndividualProgress = 1.0
    
    var body: some View {
        CircularProgressView(count: habit.completionCount, total: habit.dailyCount, showPercent: false,backgroundLineStroke: 8.0, onTopProgressStroke: 9.0, checkMarkSize: 35, countTextSize:21)
            .scaleEffect(animationAmountIndividualProgress)
            .animation(.spring(duration: 0.25, bounce: 0.5), value: animationAmountIndividualProgress)
            .onTapGesture {
                if habit.completionCount < habit.dailyCount{
                    // we have to increment the completion count here
                    var newHabit = habit
                    newHabit.completionCount += 1
                    // replace the new habit to  its original now
                    if let index = habits.habits.firstIndex(of: habit) {
                        habits.habits[index] = newHabit
                    }
                    animationAmountIndividualProgress = 1.1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        
                        animationAmountIndividualProgress = 1.0
                    }
                }
            }
    }
}



#Preview {
    DisplayHabit(habits: Habits())
}
