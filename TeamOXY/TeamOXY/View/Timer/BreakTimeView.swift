//
//  BreakTimeView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct BreakTimeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                CircularTimerView()
                VStack {
                    VStack(alignment: .center) {
                        HStack {
                            //TODO: 종료시간 func 만들기
                            // 현재 시간 기준 
                            Text("오전 11시 30분")
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
                        //TODO: 알림 on/off
                        print("알람")
                    }) {
                        HStack {
                            Image("turnOffBeep")
                            Text("알림끄기")
                        }
                        .font(.custom("Pretendard-Black", size: 16))
                        .foregroundColor(.white)
                        .frame(width: 350, height: 55)
                        .background(Color.black)
                        .clipShape(Capsule())
                    }
                }
            }
            //TODO: title 사이즈 고민하기
            .navigationBarTitle("쉬는 시간", displayMode: .inline)
        }
    }
}

//func DisplayEndTime: View {
//    var endTime = "오전 11시 30분"
//
//    return endTime
//}


struct BreakTimeView_Previews: PreviewProvider {
    static var previews: some View {
        BreakTimeView()
    }
}
