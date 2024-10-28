//
//  HabitView.swift
//  Habits
//
//  Created by Bibek Bhujel on 27/10/2024.
//

import SwiftUI

struct HabitView: View {
    let habit: Habit
    @State private var aniimationAmountIndividualProgress = 1.0
    let incrementCompletionCount: () -> Void
    let decrementCompletionCount: () -> Void
    let onComplete: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var isDescriptionEmpty: Bool {
        habit.description.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack {
                        Text(habit.habitTitle)
                            .font(.largeTitle.bold())
                        Text("Daily Goal: \(habit.dailyCount) \(habit.dailyCountUnit)")
                            .font(.title2.bold())
                    }
                    Spacer()
                    if !isDescriptionEmpty {
                        HStack {
                            Text(habit.description)
                                .font(.headline)
                                .padding()
                        }.frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius:10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray)
                            ).padding(5)
                    }
                    
                    
                    HStack {
                        Button {
                         // decrement count
                            decrementCompletionCount()
                        }label: {
                            Image(systemName: "minus")
                                .resizable()
                                .frame(width:20, height:4)
                                .font(.system(size:20, weight:.bold))
                                .foregroundStyle(.itemsBackgroundColor)
                                .padding(23)
                                .background(.lightDarkBackground)
                                .clipShape(Circle())
                        }
                       Spacer()
                        Button {
                         // increment count
                            incrementCompletionCount()
                        }label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width:20, height:20)
                                .font(.system(size:20, weight:.bold))
                                .foregroundStyle(.itemsBackgroundColor)
                                .padding(15)
                                .background(.lightDarkBackground)
                                .clipShape(Circle())
                        }
                    }.padding()
                    
                    HStack {
                        CircularProgressView(count: habit.completionCount, total: habit.dailyCount, backgroundLineStroke: 30.0, onTopProgressStroke: 31.0, checkMarkSize: 130, countTextSize: 80)
                            .scaleEffect(aniimationAmountIndividualProgress)
                            .scaleEffect(aniimationAmountIndividualProgress)
                            .animation(.spring(duration: 0.25, bounce: 0.5), value: aniimationAmountIndividualProgress)
                            .onTapGesture {
                                aniimationAmountIndividualProgress = 1.1
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        aniimationAmountIndividualProgress = 1.0
                                    }
                            }
                        
                    }.frame(maxWidth: .infinity, maxHeight:250)
                        .padding()
                    
                    Button {
                        onComplete()
                        dismiss()
                    }label: {
                        Text("Complete")
                            .font(.title3.bold())
                            .padding()
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.itemsBackgroundColor)
                    .foregroundStyle(.black)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding()
                    
                }.frame(maxWidth: .infinity)
                   
            }.preferredColorScheme(.dark)
        }
    }
}


#Preview {
    let habit = Habit(
        habitTitle: "Morning Exercise",
        description: "A routine to stay fit and active every morning. What do you think about it and also to make sure you are work as hard as possible and stay consistent in life. What are you doing right now in your life for the overall wellfare and peace in your life",
        type: "Health",
        habitGoal: "30 minutes",
        dailyCount: 1,
        dailyCountUnit: "session"
    )

    HabitView(habit: habit, incrementCompletionCount: {}, decrementCompletionCount: {}, onComplete: {})
}
