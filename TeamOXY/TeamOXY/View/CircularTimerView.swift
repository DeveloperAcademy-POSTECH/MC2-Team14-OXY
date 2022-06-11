//
//  TimerViewUI.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct CircularTimerView: View {
//    var counter: Int
//    var countTo: Int
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.4)
//                .trim(from: 0.0, to: (progress() == 0 ? 0.000001 : progress()))
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .opacity(0.1)
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(-90))
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.1)
                .frame(width: 300, height: 300)
            Text("07:10")
                .font(.custom("Pretendard-Thin", size: 50))
        }
        
    }
    
//    func completed() -> Bool {
//        return progress() == 1
//    }
//
//    func progress() -> CGFloat {
//        return (CGFloat(counter) / CGFloat(countTo))
//    }
    
}


struct CircularTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CircularTimerView()
    }
}
