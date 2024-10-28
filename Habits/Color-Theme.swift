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
    
    static var circularProgressFillStrokeColor: Color {
        Color(red: 58/255, green: 58/255, blue: 60/255, opacity: 1.0)
    }
    
    static var inProgressFillColor1: Color {
        Color(red: 177 / 255.0, green: 92 / 255.0, blue: 241 / 255.0, opacity: 255 / 255.0)
    }
    
    static var inProgressFillColor2: Color {
        Color(red: 56 / 255.0, green: 120 / 255.0, blue: 249 / 255.0, opacity: 255 / 255.0)
    }
    
    static var progressCompleteFillColor1: Color {
        Color(red: 46 / 255.0, green: 208 / 255.0, blue: 87 / 255.0, opacity: 255 / 255.0)
    }
    
    static var progressCompleteFillColor2: Color {
        Color(red: 98 / 255.0, green: 208 / 255.0, blue: 254 / 255.0, opacity: 255 / 255.0)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
}
