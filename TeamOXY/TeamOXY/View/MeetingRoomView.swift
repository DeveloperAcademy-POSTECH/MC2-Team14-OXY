//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    @State private var showingLeaveRoomSheet: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Spacer()
                    Rectangle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                        .frame(width: smallCardWidth * 2.4,height: smallCardHeight * 2.4)
                        .foregroundColor(.gray.opacity(0.5))
                        .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
                        .offset(y: -95)

                    CarouselView(views: [
                        Image("Card1"),
                        Image("Card2"),
                        Image("Card3"),
                        Image("Card4"),
                        Image("Card5"),
                        Image("Card6"),
                        Image("Card6")
                    ])
            }
            }
            .confirmationDialog("방을 정말 떠나시겠습니까?",
                                isPresented: $showingLeaveRoomSheet,
                                titleVisibility: .visible) {
                Button("떠나기") {
                    print("떠나기")
                }
                Button("취소", role: .cancel) {
                }
            } message: {
                Text("방에 다시 입장하려면 팀원들의 QR코드를 통해 입장해주세요")
            }
            .navigationTitle("익명의 원숭이 방 6")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingLeaveRoomSheet.toggle()
                    }) {
                        Image("Button_LeaveRoom")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                            .imageScale(.large)
                    }
                }
                
            })
        }
    }
}

struct MeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomView()
    }
}
