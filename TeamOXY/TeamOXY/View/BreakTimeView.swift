//
//  BreakTimeView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI



struct BreakTimeView: View {
    
    // 설정된 시간
//    @Binding var counter: Int
//    @Binding var countTo: Int
    @State var counter: Int
    @State var countTo: Int
    
    // 알람 설정
    @State private var isNotification = false
    
    var body: some View {
        NavigationView {
            ZStack {
                CircularTimerView(counter: counter, countTo: countTo)
                VStack {
                    VStack(alignment: .center) {
                        HStack {
                            //TODO: 종료시간 func 만들기
                            Text(displayFinish())
                                .foregroundColor(/*@START_MENU_TOKEN@*/Color("PrimaryBlue")/*@END_MENU_TOKEN@*/)
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
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func displayFinish() -> String{
        let now = Date()
        //.addingTimeInterval(TimeInterval)
        //TODO: 시간 추가 개선, 시작시간 고정하고 끝나는 시간 보내는 방법?
        // 종료시간 값 넣어줘야함
        // 업데이트 없이, 초반에 정한 값으로 픽스하고 싶다.
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
