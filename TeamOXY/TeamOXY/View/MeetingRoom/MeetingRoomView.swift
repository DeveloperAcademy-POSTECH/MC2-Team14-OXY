//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    @AppStorage("roomId") var roomId: String!
    
    @ObservedObject var vm: RoomViewModel
    
    @State private var showLeaveRoomSheet: Bool = false
    @State private var showQRCode = false
    
    @Binding var backToHome: Bool
    
    @State var isActive: Bool = (timerViewModel.shared.currentTimer?.isAvailable ?? false)
    
    var scannedCodeUrl: String?
    
    var body: some View {
        VStack {
            //            if vm.isTimerAvailable {
            //                BreakTimeView(counter: 0, countTo: 100, vm: vm, viewModel: viewModel)
            //                    .onAppear{
            //                        // 설정한 사람이 아닌 다른 사람의 폰에서도 미팅룸 초기화면으로 돌아가게하기위함
            //                        viewModel.FinishTopicViewCondition = [false, true, false]
            //                        viewModel.isCardBox = true
            //                        viewModel.isCardDeck = true
            //                        self.viewModel.topicTitle = ""
            //                        self.viewModel.storeTopicInformation()
            //
            //                        self.viewModel.ownNotification = true
            //                    }
            //            } else {
            //                ZStack{
            //                    if viewModel.FinishTopicViewCondition != [false, true, true] && viewModel.isCardBox {
            //                        RoundedRectangle(cornerRadius: 5)
            //                            .strokeBorder(style: StrokeStyle(lineWidth: 1))
            //                            .frame(width: CarouselViewConstants.smallCardWidth * 2.4,height: CarouselViewConstants.smallCardHeight * 2.4)
            //                            .foregroundColor(.gray.opacity(0.2))
            //                            .overlay(content: {
            //                                HStack(spacing:0) {
            //                                    Text("카드를 올려")
            //                                        .font(.custom("Pretendard-Light", size: 12))
            //                                    Text(" 쉬는 시간")
            //                                        .font(.custom("Pretendard-Light", size: 12))
            //                                        .foregroundColor(Color.PrimaryBlue)
            //                                    Text("을 제안해보세요")
            //                                        .font(.custom("Pretendard-Light", size: 12))
            //                                }
            //                            })
            //                            .offset(y: -UIScreen.screenHeight * 0.11)
            //                            .transition(AnyTransition.opacity.animation(.easeInOut))
            //                    }
            //
            //                    CarouselView(viewModel: viewModel, vm: vm, emojiViewModel: emojiViewModel)
            //                }
            //            }
            //        }
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
                .navigationTitle("\(roomId) \(2)")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showLeaveRoomSheet.toggle()
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
                }
                .confirmationDialog("방을 정말 떠나시겠습니까?",
                                    isPresented: $showLeaveRoomSheet,
                                    titleVisibility: .visible) {
                    Button("떠나기") {
                        backToHome = false
                        // 파이어스토어에서 방에서 유저를 삭제
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            // 방을 나간 유저가 있으므로 현재 방에 있는 유저를 다시 불러온다. (안불러도 자동으로 될 수도)
                        }
                    }
                    Button("취소", role: .cancel) { }
                } message: {
                    Text("방에 다시 입장하려면 팀원들의 QR코드를 통해 입장해주세요")
                }
                .fullScreenCover(isPresented: $showQRCode) {
                                        QRCodeView(url: roomId)
                }
        }
    }
}
