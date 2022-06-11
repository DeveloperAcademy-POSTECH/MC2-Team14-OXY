//
//  TimerViewUI.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct CircularTimerView: View {
    @State var counter: Int = 0
    @State var countTo: Int = 60 * 10 // 10 minutes
    
    var body: some View {
        ZStack {
            CircularProgressBar(counter: counter, countTo: countTo)
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.1)
                .frame(width: 300, height: 300)
            DigitClock(counter: counter, countTo: countTo)

        }
    }
}

struct CircularProgressBar: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        // count: 3분 차이 -> 색상 바꾸기
        Circle()
            .trim(from: 0.0, to: (progress() == 1 ? 1 : progress()))
            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
            .opacity(0.1)
            .frame(width: 300, height: 300)
            .rotationEffect(.degrees(-90))
            .animation(Animation.linear(duration: 2.0))
    }
    
    //완료
    func completed() -> Bool {
        return progress() == 0
    }
    
    //진행상황
    func progress() -> CGFloat {
        //MARK: 임시 리턴값
        return 0.9
        //실제 진행상황은 아래값으로 리턴
//        return (1 - CGFloat(counter) / CGFloat(countTo))
    }
    
}

struct DigitClock: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        Text(counterToMinutes())
            .font(.custom("Pretendard-Thin", size: 50))
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}


struct CircularTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CircularTimerView()
    }
}
