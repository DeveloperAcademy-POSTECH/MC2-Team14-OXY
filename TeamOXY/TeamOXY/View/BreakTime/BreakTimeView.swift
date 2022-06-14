//
//  BreakTimeView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct BreakTimeView: View {
    
    // 설정된 시간
    @State var counter: Int
    @State var countTo: Int
    
    // 알람 설정
    @State private var isNotification = false
    
    var body: some View {
        ZStack {
            CircularTimerView(counter: counter, countTo: countTo)
            VStack {
                VStack(alignment: .center) {
                    HStack {
                        //TODO: 종료시간 firebase에서 받아오기
                        Text(displayFinish())
                            .foregroundColor(Color("PrimaryBlue"))
                        Text("까지")
                    }
                    Text("쉬는 시간입니다.")
                }
                .font(.custom("Pretendard-ExtraBold", size: 24))
                .padding(.bottom, 50.0)
                .padding(.top, 70.0)
                
                Spacer()
                
                Button(action: {
                    //TODO: notification setting
                    
                    print("알람")
                    if isNotification == true {
                        isNotification = false
                    }
                    else {
                        isNotification = true
                    }
                }) {
                    if isNotification == true {
                        HStack {
                            Image("turnOffBeep")
                            Text("알림 끄기")
                        }
                        .font(.custom("Pretendard-Black", size: 16))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                        .background(Color.black)
                        .clipShape(Capsule())
                    }
                    else {
                        HStack {
                            Image("turnOnBeep")
                            Text("알림 켜기")
                        }
                        .font(.custom("Pretendard-Black", size: 16))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                        .background(Color.PrimaryBlue)
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .navigationBarTitle("쉬는 시간", displayMode: .inline)
        
        .navigationBarBackButtonHidden(true)
        
    }
    
    func displayFinish() -> String{
        let now = Date()
        //TODO: 종료시간 받아와서 출력하기, 알람에 상관없이 고정된 시간을 표현해야함
        //MARK: 알람버튼 누를 때, 종료시간 업데이트되는 것 막아야함
        let end = now.addingTimeInterval(600)
        let formatter = DateFormatter()
        //한국 시간으로 표시
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //형태 변환, a:오전,오후 심볼표시
        formatter.dateFormat = "a hh:mm"
        formatter.amSymbol = "오전"
        formatter.pmSymbol = "오후"
        
        return formatter.string(from: end)
    }
}

//struct BreakTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreakTimeView()
//    }
//}