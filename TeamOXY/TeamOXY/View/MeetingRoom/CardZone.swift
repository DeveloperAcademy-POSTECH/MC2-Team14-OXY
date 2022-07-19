//
//  CardZone.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/07/19.
//

import SwiftUI

struct CardZone: View {
    
    @AppStorage("roomId") var roomId: String!
    @ObservedObject var vm: RoomViewModel
    
    @Binding var showLeaveRoomSheet: Bool
    @Binding var showQRCode: Bool
    @Binding var backToHome: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .strokeBorder(style: StrokeStyle(lineWidth: 1))
            .frame(width: CarouselViewConstants.smallCardWidth * 2.4,height: CarouselViewConstants.smallCardHeight * 2.4)
            .foregroundColor(.gray.opacity(0.2))
            .overlay(content: {
                HStack(spacing:0) {
                    Text("카드를 올려")
                        .font(.custom("Pretendard-Light", size: 12))
                    Text(" 쉬는 시간")
                        .font(.custom("Pretendard-Light", size: 12))
                        .foregroundColor(Color.PrimaryBlue)
                    Text("을 제안해보세요")
                        .font(.custom("Pretendard-Light", size: 12))
                }
            })
            .offset(y: -UIScreen.screenHeight * 0.11)
            .transition(AnyTransition.opacity.animation(.easeInOut))
    }
}
