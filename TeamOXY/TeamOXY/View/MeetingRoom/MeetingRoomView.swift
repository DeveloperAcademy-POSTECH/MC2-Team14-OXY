//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    
    @ObservedObject var viewModel = CompletionViewModel()
    
    @State private var showingLeaveRoomSheet: Bool = false
    @State private var showQRCode = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    if viewModel.FinishTopicViewCondition != [false, true, true] && viewModel.isCardBox {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1))
                            .frame(width: smallCardWidth * 2.4,height: smallCardHeight * 2.4)
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
                    }
                    
                    CarouselView(viewModel: viewModel,views: [
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
                        showQRCode.toggle()
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                            .imageScale(.large)
                    }
                }
                
            })
        }
        .fullScreenCover(isPresented: $showQRCode) {
            QRCodeView()
        }
    }
}

struct MeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomView()
    }
}
