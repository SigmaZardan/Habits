//
//  ContentView.swift
//  Habits
//
//  Created by Bibek Bhujel on 22/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddNewHabit = false
    @State private var habits = Habits() // keeping the object alive with state, also var because state must be var type
    
    var hasNoHabits: Bool {
        habits.habits.isEmpty
    }
    
    
    var showScrollViewIndicators: Bool {
        hasNoHabits ? false : true
    }
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators:showScrollViewIndicators) {
                if hasNoHabits {
                    FirstMotivationView(showAddNewHabit: $showAddNewHabit)
                } else {
                    DisplayHabit(habits: habits)
                }
            }
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                   // add new view
                    showAddNewHabit = true
                }label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width:20, height:20)
                        .font(.system(size:20, weight:.bold))
                        .foregroundStyle(.itemsBackgroundColor)
                        .padding(15)
                        .background(.lightDarkBackground)
                        .clipShape(Circle())
                        .padding(.bottom)
                }
            }
            .sheet(isPresented: $showAddNewHabit) {
                AddNewHabit(habits: habits)
            }
        }
    }
}


struct FirstMotivationView: View {
    @Binding var showAddNewHabit: Bool
    
    var body: some View {
        VStack{
            Image("habitascent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 120)
                .clipShape(Circle())
            VStack {
                MotivationQuoteTitleView(title: "Success Begins with")
                MotivationQuoteTitleView(title: " small steps")
                
            }.padding(.vertical)
        
            VStack(spacing:30){
                MotivationQuoteLabelView(label: "Build good habits.")
                MotivationQuoteLabelView(label: "Break Bad habits.")
                MotivationQuoteLabelView(label: "Stay Consistent.")
            }
            
            HStack {
                Spacer()
                    .frame(maxWidth: 50)
                
                Button {
                    // add first habit
                    showAddNewHabit = true
                }label: {
                    Text("Add first habit")
                        .font(.title3.bold())
                        .padding()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(.itemsBackgroundColor)
                .foregroundStyle(.black)
                .clipShape(.rect(cornerRadius: 12))
                
                Spacer()
                    .frame(maxWidth: 50)
            }.padding(.vertical)
            
        }.frame(maxWidth: .infinity)
            .padding(.vertical, 75)
    }
}

struct MotivationQuoteTitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.largeTitle.bold())
    }
}

struct MotivationQuoteLabelView: View {
    let label: String
    var body: some View {
        Text(label)
            .font(.title2)
    }
}


#Preview {
    ContentView()
}
