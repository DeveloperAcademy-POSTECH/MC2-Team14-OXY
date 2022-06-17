//
//  TimerViewUI.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI



struct CircularTimerView: View {
    @State var counter: Int
    @StateObject var viewModel: PushNotification = PushNotification()
    @State var deviceToken = "frH1tHH_bEGyl7ow8yOy0k:APA91bH43KmEnnR99ZNXoElsT9700nyoMcNNrSWdWYR9bUCqWpT4H3sMSzy1xw52-HzOOB9v1NG3SvvErxaLVk-GPbTI1oNKBDTeY0AMg6fBD6nI7OwzzspF7phl_JjMBURNK2pzpVBi"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
            if self.countTo - counter == 180 {
                print(TokenModel.shared.token ?? "")
                //                viewModel.sendMessageToDevice(token: TokenModel.shared.token ?? "", data: ["hi":"hi"])
                sendMessageToDevice()
            }
        }
        .onAppear {
            NotificationManager.shared.TimeIntervalNotification(time: countTo - 180, title: "이쉼전쉼", subtitle: "쉬는시간이 3분 남았습니다.⏰")
            NotificationManager.shared.TimeIntervalNotification(time: countTo, title: "이쉼전쉼", subtitle: "쉬는시간 끝! 모두 모여주세요.🏃‍♂️")
        }
        
    }
    
    func sendMessageToDevice() {
//        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {
            return
        }
        
        let json: [String:Any] = [
            "to": deviceToken,
            "notification": [
                "title": "hi",
                "body": "I'm Dake"
            ],
            "data": [
                "user_name": "myName"
            ]
        ]
        
        let serverKey = "AAAANndUIbE:APA91bHBqe3LIWHOYbSPo-ufMGgKjm1znplyv5J_Q70LMXel9noqnHH1FtbVkHEGSFYfeqK_jgOyfsoeoNHFSL6Bb3Z3vPY6BhOs3cEDng3RXWaRLo-UNPnivkeyClkzotMoJy7N1HRc"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            print("Success")
            DispatchQueue.main.async { [self] in
             
                deviceToken = ""
            }
        }
        .resume()
    }

}

struct CircularProgressBar: View {
    @State var progress = 0.0
    
    var counter: Int
    var countTo: Int
    
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
            .timer1()
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}
