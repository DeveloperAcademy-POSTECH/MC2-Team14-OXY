//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    
    var scannedCodeUrl: String?
    
    @ObservedObject var viewModel = CompletionViewModel()
    @ObservedObject var vm = MeetingRoomViewModel()
    
    @State private var showingLeaveRoomSheet: Bool = false
    @State private var showQRCode = false
    @State private var loginStatusMessage = ""
    @State private var nickname = ""
    
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
        .navigationTitle("\(vm.currentUser?.nickname ?? "") 방 \(vm.users.count)")
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
                backToHome = false
            }
            Button("취소", role: .cancel) {
                
            }
        } message: {
            Text("방에 다시 입장하려면 팀원들의 QR코드를 통해 입장해주세요")
        }
        .fullScreenCover(isPresented: $showQRCode) {
            QRCodeView(url: vm.roomId)
        }
        .onAppear {
            DispatchQueue.main.async {
                nickname = generateRandomNickname()
                anonymousLogin()
                guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
                
                print("Current User",uid)
            }
        }
    }
    
    private func anonymousLogin() {
        FirebaseManager.shared.auth.signInAnonymously { result, error in
            if let error = error {
                print("Failed to Anonymous login user: \(error)")
                loginStatusMessage = "Failed to Anonymous login user: \(error)"
                return
            }
            
            print("Successfully logged in user: \(result?.user.uid ?? "")")
            loginStatusMessage = "Successfully logged in user: \(result?.user.uid ?? "")"
            
            self.storeUserInformation()
        }
    }
    
    private func storeUserInformation() {
        if let scannedCodeUrl = scannedCodeUrl {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            
            let userData = [
                FirebaseConstants.uid: uid,
                FirebaseConstants.nickname: nickname
            ]
            
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(scannedCodeUrl)
                .collection(FirebaseConstants.users)
                .document(uid)
                .setData(userData) { error in
                    if let error = error {
                        print("Failed to store user information: \(error)")
                        return
                    }
                    
                    print("Succeessfully stored user information")
                    
                    self.vm.fetchCurrentUser(scannedCodeUrl)
                }
        } else {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            
            let userData = [
                FirebaseConstants.uid: uid,
                FirebaseConstants.nickname: nickname
            ]
            
            vm.roomId = "room \(uid)"
            
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(vm.roomId)
                .collection(FirebaseConstants.users)
                .document(uid)
                .setData(userData) { error in
                    if let error = error {
                        print("Failed to store user information: \(error)")
                        return
                    }
                    
                    print("Succeessfully stored user information")
                    
                    self.vm.fetchCurrentUser(vm.roomId)
                }
        }
    }
    
    private func leaveMeetingRoom() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
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
                
                self.vm.fetchCurrentUser(vm.roomId)
            }
    }
}

struct MeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomView(scannedCodeUrl: nil, backToHome: .constant(true))
    }
}
