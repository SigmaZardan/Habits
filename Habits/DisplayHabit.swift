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
       
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        LazyVStack {
            VStack {
                
                HStack {
                    CircularProgressView(count: count, total: total, showPercent: true,backgroundLineStroke: 30.0, onTopProgressStroke: 31.0, checkMarkSize: 130, countTextSize: 80)
                        .scaleEffect(animationAmount)
                        .animation(.spring(duration: 0.25, bounce: 0.5), value: animationAmount)
                        .onTapGesture {
                            if count < total {
                                count += 1
                                animationAmount = 1.1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                   
                                    animationAmount = 1.0
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
                            CircularProgressView(count: count, total: total, showPercent: false,backgroundLineStroke: 8.0, onTopProgressStroke: 9.0, checkMarkSize: 35, countTextSize:21)
                                .scaleEffect(animationAmount)
                                .animation(.spring(duration: 0.25, bounce: 0.5), value: animationAmount)
                                .onTapGesture {
                                    if count < total {
                                        count += 1
                                        animationAmount = 1.1
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            
                                            animationAmount = 1.0
                                        }
                                    }
                                }
                        }.frame(maxHeight: 70).padding()
                    }.frame(maxWidth: .infinity)
                        .background(.lightDarkBackground)
                        .clipShape(.rect(cornerRadius:10))
                        .padding(5)
                    
                }
            }
        }.preferredColorScheme(.dark)
    }
}





#Preview {
    DisplayHabit(habits: Habits())
}
