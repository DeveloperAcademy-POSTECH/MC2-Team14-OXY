//
//  ProgressSet.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct ProgressTrack: View {
    var body: some View {
        Circle()
            .stroke(lineWidth: 14)
            .padding(.horizontal, 65)
            .opacity(0.1)
    }
}

//struct ProgressBar: View {
//    var counter: Int
//    var countTo: Int
//
//    var body: some View {
//        Circle()
//            .trim(from: 0.0, to: (progress() == 0.000001 : progress()))
//            .stroke(style: StrokeStyle(lineWidth:20, lineCap: .round, lineJoin: .round))
//            .opacity(0.2)
//            .rotationEffect(.degrees(-90))
//            .animation(Animation.linear(duration: 2.0))
//    }
//
//    func completed() -> Bool {
//        return progress() == 1
//    }
//
//    func progress() -> CGFloat {
//        return (CGFloat(counter) / CGFloat(countTo))
//    }
//}

//struct DigitClockView: View {
//    var counter: Int
//    var countTo: Int
//
//    var body: some View {
//        Text(counterToMinutes().font(.system(size: 70)))
//    }
//}
