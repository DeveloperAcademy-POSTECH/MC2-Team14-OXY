//
//  TimerViewUI.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

struct CircularTimerView: View {
    
    @State var counter: Int
    var countTo: Int
    
    var body: some View {
        ZStack {
            CircularProgressBar(counter: counter, countTo: countTo)
            DigitClock(counter: counter, countTo: countTo)
        }
        // 1초마다 업데이트
        .onReceive(timer) { timer in
            if (self.counter < self.countTo) {
                self.counter += 1
            }
        }
    }
}

struct CircularProgressBar: View {
    var counter: Int
    var countTo: Int
    
    @State var progress = 0.0
    
    var body: some View {
        ZStack {
            // 3분 남았을 때, 색 변화
            Circle()
                .trim(from: 0.0, to: min(progressConvert(), 1.0))
                .stroke(countTo - counter < 180 ? Color.red : Color.PrimaryBlue, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: progressConvert())
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.1)
                .frame(width: 300, height: 300)
        }
    }
    
    //완료
    func completed() -> Bool {
        return progressConvert() == 0
    }
    
    //남은 시간 = 전체시간 - 지난시간
    func progressConvert() -> CGFloat {
        return (1 - CGFloat(counter) / CGFloat(countTo))
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


//struct CircularTimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularTimerView()
//    }
//}
