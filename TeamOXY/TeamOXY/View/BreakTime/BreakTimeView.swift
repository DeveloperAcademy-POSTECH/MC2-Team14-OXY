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
    @ObservedObject var vm: MeetingRoomViewModel
    @ObservedObject var viewModel: CarouselViewModel
    // 알람 설정
    @State private var isNotification = true
    
    var body: some View {
        ZStack {
            CircularTimerView(counter: counter, countTo: timerViewModel.shared.currentTimer?.timestamp ?? 0, vm: vm, isNotification: $isNotification)
            
            VStack {
                VStack(alignment: .center) {
                    HStack {
                        //TODO: 종료시간 firebase에서 받아오기
                        Text(displayFinish())
                            .foregroundColor(.PrimaryBlue)
                        
                        Text("까지")
                    }
                    
                    Text("쉬는 시간입니다.")
                }
                .headLine1()
                .padding(.bottom, 50.0)
                .padding(.top, 70.0)
                
                Spacer()
                
                RoundButton(buttonType: .primary, title: isNotification ? "알림켜짐" : "알림꺼짐", isButton: true, color: isNotification ? .PrimaryBlue : .DarkGray1) {
                    //TODO: notification setting
                    
                    isNotification.toggle()
                }
            }
        }
        .navigationBarTitle("쉬는 시간", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
    func displayFinish() -> String{
        let now = timerViewModel.shared.currentTimer?.setTime
        //TODO: 종료시간 받아와서 출력하기, 알람에 상관없이 고정된 시간을 표현해야함
        //MARK: 알람버튼 누를 때, 종료시간 업데이트되는 것 막아야함
        guard let end = now?.addingTimeInterval(Double(timerViewModel.shared.currentTimer?.timestamp ?? 0)) else { return "Date()" }
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
//        BreakTimeView(counter: 1, countTo: 1)
//    }
//}
