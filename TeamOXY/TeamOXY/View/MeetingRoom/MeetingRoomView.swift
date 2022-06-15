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
    
    var scannedCodeUrl: String?
    
    @State private var showingLeaveRoomSheet: Bool = false
    @State private var showQRCode = false
    @State private var nickname = generateRandomNickname()
    
    @Binding var backToHome: Bool
    
    var body: some View {
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
                                Text(" 쉬는 시간")
                                    .foregroundColor(Color.PrimaryBlue)
                                Text("을 제안해보세요")
                            }
                            .body2()
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
        .navigationTitle("\(vm.roomId) \(vm.users.count < 2 ? 1 : vm.users.count)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
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
        }
        .confirmationDialog("방을 정말 떠나시겠습니까?",
                            isPresented: $showingLeaveRoomSheet,
                            titleVisibility: .visible) {
            Button("떠나기") {
                self.leaveMeetingRoom()
                backToHome = false
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("방에 다시 입장하려면 팀원들의 QR코드를 통해 입장해주세요")
        }
        .fullScreenCover(isPresented: $showQRCode) {
            QRCodeView(url: vm.roomId)
        }
        .onAppear {
            print("room id \(vm.roomId)")
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
                    
                    print("방에 있는 인원은 듣거라", self.vm.users)
                    
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
                    
                    self.vm.roomId = ""
                    self.vm.currentUser = nil
                }
        }
    }
}
