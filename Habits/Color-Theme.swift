//
//  Color-Theme.swift
//  Habits
//
//  Created by Bibek Bhujel on 22/10/2024.
//

import SwiftUI


extension ShapeStyle where Self == Color {
    static var itemsBackgroundColor: Color {
        Color(red: 134/255, green: 132/255, blue: 255/255)
    }
    static var darkBackground: Color {
        Color(red: 0.051, green: 0.051, blue: 0.051)
    }
    
    static var lightDarkBackground: Color {
        Color(red: 0.15, green: 0.15, blue: 0.15)
    }
    
    static var sheetBackgroundColor: Color {
        Color(red: 36/255, green: 36/255, blue: 38/255)
    }
    
    static var sectionBackgroundColor: Color {
        Color(red: 54/255, green: 54/255, blue: 56/255)
    }
}
