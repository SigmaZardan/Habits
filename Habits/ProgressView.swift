//
//  ProgressView.swift
//  Habits
//
//  Created by Bibek Bhujel on 26/10/2024.
//

import SwiftUI

struct CircularProgressView: View {
    
    let count: Int
    
    let total: Int
    
    var showPercent: Bool = false
    
    var progress: CGFloat {
        return CGFloat(count) / CGFloat(total)
    }
    
    var showBottomText: Bool = false
    var bottomText: String = ""
    
    let fill = LinearGradient(colors: [.inProgressFillColor1, .inProgressFillColor2], startPoint: .top, endPoint: .bottom)
    
    let fill2 = LinearGradient(colors:[.progressCompleteFillColor1,.progressCompleteFillColor2], startPoint: .top, endPoint: .bottom)
    
 
    
    var countText: String {
        return if showPercent {
            "\(Int(progress * 100))%"
        } else {
            "\(count)"
        }
    }
    
    let backgroundLineStroke: CGFloat
    
    let onTopProgressStroke: CGFloat
    
    let checkMarkSize:  CGFloat
    
    let countTextSize: CGFloat
    
    var bottomTextSize: CGFloat = 50.0
    
    
    var body: some View {
        ZStack{
            //Background line for progress
            Circle()
                .stroke(lineWidth: backgroundLineStroke)
                .opacity(0.3)
                .foregroundStyle(Color.secondary)
            
            Circle()
                .trim(from: 0.0, to:CGFloat(min(progress, 1.0)) )
                .stroke(count == total ? fill2 : fill ,style: StrokeStyle(lineWidth: onTopProgressStroke, lineCap: CGLineCap.round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            VStack {
                if count == total {
                   // show check mark with animation
                        Image(systemName: "checkmark")
                        .font(.system(size:checkMarkSize,weight:.bold))
                            .foregroundStyle(Color.green)
                } else {
                    Text(countText)
                        .font(Font.system(size: countTextSize, weight: .bold, design: .rounded))
                    if showBottomText {
                        Text(bottomText).font(Font.system(size: bottomTextSize, weight:.bold))
                    }
                }
            }
            
        }
    }
}
