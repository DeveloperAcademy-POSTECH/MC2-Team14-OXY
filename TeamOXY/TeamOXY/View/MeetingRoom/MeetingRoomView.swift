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
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    
    @State private var showLeaveRoomSheet: Bool = false
    @State private var showQRCode = false
    
    @Binding var backToHome: Bool
    
    var scannedCodeUrl: String?
    var roomTitle: String? = nil
    
    var body: some View {
        VStack {
            if !userViewModel.isLogin {
                AnonymousLoginLoadingView()
                    .navigationBarBackButtonHidden(true)
            } else {
                ForEach(vm.meetingRooms) { meetingRoom in
                    if meetingRoom.isStarted {
                        CardZone(vm: vm, showLeaveRoomSheet: $showLeaveRoomSheet, showQRCode: $showQRCode, backToHome: $backToHome)
                        
                        if !meetingRoom.isSuggested {
                            // TODO: - 캐러셀 뷰 넣기
                        } else {
                            // TODO: - 리액션 뷰 넣기
                        }
                        
                    } else if meetingRoom.isConfirmed {
                        FinishTopicView(vm: vm)
                    } else if meetingRoom.isSettingTimer {
                        TimeSetView(vm: vm)
                    }
                }
                .navigationTitle("\(roomId) \(vm.usersCount)")
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
                        userViewModel.leaveMeetingRoom(roomId: roomId)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            // 방을 나간 유저가 있으므로 현재 방에 있는 유저를 다시 불러온다. (안불러도 자동으로 될 수도)
                            vm.getUserCount(roomId: roomId)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            if vm.usersCount == 1 {
                                vm.deleteMeetingRoom(roomId: roomId)
                            }
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
        .onAppear {
            userViewModel.anonymousLogin(roomId: roomId, nickname: generateRandomNickname())
            vm.fetchMeetingRooms(roomId: roomId)
            vm.getUserCount(roomId: roomId)
        }
    }
}
