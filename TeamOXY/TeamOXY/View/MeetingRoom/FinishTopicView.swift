//
//  FinishTopicView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/12.
//

import SwiftUI

struct FinishTopicView: View {
    @AppStorage("roomId") var roomId: String!
    
    @ObservedObject var vm: RoomViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Text("🕰⏰🕰⏰")
                    .font(.system(size: 58))
                    .padding(.bottom, UIScreen.screenHeight * 0.044)

                Text("쉬는 시간을\n 설정하시겠습니까?")
                    .headLine1()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, UIScreen.screenHeight * 0.044)
                HStack {
                    Button {
                        vm.startMeeting(roomId: roomId)
                    } label: {
                        Circle()
                            .stroke(Color("PrimaryBlue"))
                            .frame(width: UIScreen.screenWidth * 0.148, height: UIScreen.screenWidth * 0.148, alignment: .center)
                            .overlay(Text("아니요")
                                .button1()
                                .foregroundColor(Color("PrimaryBlue")))
                    }
                    
                    Spacer()
                    
                    // TimeSetView 쉬는시간설정 뷰로 이동
                    Button {
                        vm.completedSuggestion(roomId: roomId)
                    } label: {
                        Circle()
                            .fill(Color("PrimaryBlue"))
                            .frame(width: UIScreen.screenWidth * 0.148, height: UIScreen.screenWidth * 0.148,  alignment: .center)
                            .overlay(Text("네")
                                .button1()
                                .foregroundColor(.white))
                    }

                }
                .padding(.horizontal, UIScreen.screenWidth * 0.102)
            }
            .padding(.horizontal, UIScreen.screenWidth * 0.158)
        }
    }
}
