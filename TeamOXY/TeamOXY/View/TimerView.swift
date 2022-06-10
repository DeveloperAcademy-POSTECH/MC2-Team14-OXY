//
//  TimerView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/09.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack {
            Text("쉬는시간")
            Text("오전 11시 30분까지 쉬는 시간입니다.")
                .font(.custom("Pretendard-ExtraBold", size: 24))
            ZStack {
                ProgressTrack()
                    
                Text("06:32")
                    .font(.largeTitle)
            }
            Button(action: {
                print("turn off beep")
                
            }) {
                Image("turnOffBeep")
                Text("알림 끄기")
                   
            }
            // 350 55 , primaryBlue
            .foregroundColor(.white)
            .frame(width: 350, height: 55)
            //TODO: color 맞추기
            .background(Color.Blue)
            .clipShape(Capsule())
            
        }
        
    }
}

//struct TimerProgress: View {
//
//}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
