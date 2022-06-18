//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    @ObservedObject var vm: MeetingRoomViewModel
    @ObservedObject var viewModel = CompletionViewModel()
    @ObservedObject var emojiViewModel = EmojiViewModel()
    
    @State private var showLeaveRoomSheet: Bool = false
    @State private var showQRCode = false
    
    @Binding var backToHome: Bool
    
    @State var isActive: Bool = (timerViewModel.shared.currentTimer?.isAvailable ?? false)
    
    var scannedCodeUrl: String?
    
    var body: some View {
            VStack {
                if vm.isTimerAvailable {
                    BreakTimeView(counter: 0, countTo: 100, vm: vm)
                }
                else {
                    ZStack{
                        if viewModel.FinishTopicViewCondition != [false, true, true] && viewModel.isCardBox {
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
                        
                        CarouselView(viewModel: viewModel, emojiViewModel : emojiViewModel, vm: vm, views: [
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
        }
        .navigationTitle("\(vm.roomId) \(vm.users.count < 2 ? 1 : vm.users.count)")
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
                leaveMeetingRoom()
                backToHome = false
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("방에 다시 입장하려면 팀원들의 QR코드를 통해 입장해주세요")
        }
        .fullScreenCover(isPresented: $showQRCode) {
            QRCodeView(url: vm.roomId)
        }
    }
    
    private func leaveMeetingRoom() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        // 방에 2명이상 있는 경우
        if vm.users.count > 1 {
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(vm.roomId)
                .collection(FirebaseConstants.users)
                .document(uid)
                .delete { error in
                    if let error = error {
                        print("Failed to delete user: \(error)")
                        return
                    }
                    
                    // MeetingRoomViewModel에 있는 users 배열에서 currentUser와 같은 uid를 가지면 제거
                    self.vm.users = self.vm.users.filter({ user in
                        uid != user.uid
                    })
                    
                    print("Successfully delete user information in meeting room")
                    
                    self.vm.roomId = ""
                    self.vm.currentUser = nil
                }
            // 방에 혼자 있는 경우
        } else if vm.users.count == 1 {
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(vm.roomId)
                .delete { error in
                    if let error = error {
                        print("Failed to delete user: \(error)")
                        return
                    }
                    
                    // MeetingRoomViewModel에 있는 users 배열 비우기
                    self.vm.users.removeAll()
                    
                    print("Successfully delete meeting room information")
                    
                    self.vm.roomId = ""
                    self.vm.currentUser = nil
                }
        }
    }
}
