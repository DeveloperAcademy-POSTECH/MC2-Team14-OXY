//
//  TimerViewUI.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI


// MARK: timer issue
// TODO: 여기부터 수정해야함.
// timer도 파이어베이스 DB에 저장해야함

// 바로 시작. 이거 어디서 썼지? 찾았으면 이건 지워야함 !
let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

struct CircularTimerView: View {
    
    @State var counter: Int
    var countTo: Int
    
    var body: some View {
        ZStack {
            CircularProgressBar(counter: counter, countTo: countTo)
            DigitClock(counter: counter, countTo: countTo)
        }
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
            // count: 3분 차이 -> 색상 바꾸기
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
    
    //진행상황
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
