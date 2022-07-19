//
//  HomeView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/09.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @AppStorage("roomId") var roomId: String?
    
    @StateObject var vm = RoomViewModel()
    
    @State var roomCode: String = ""
    @State private var isPresentingScanner = false
    @State private var scannedCodeUrl = ""
    @State var backToHome = false
    @State var moveToCreate = false
    
    var scannerSheet: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr]) { result in
                if case let .success(code) = result {
                    scannedCodeUrl = code.string
                    isPresentingScanner = false
                    backToHome = true
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPresentingScanner = false
                    } label: {
                        Image(systemName: "xmark")                            
                            .font(.title2)
                    }
                    .foregroundColor(.black)
                }
                .padding()
                .background(.white)
                
                Spacer()
                
                HStack { Spacer() }
                    .background(.white)
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenWidth * 0.4 * (122/156))
                
                Text("이쉼전쉼")
                    .font(.custom("Pretendard-Black", size: 46))
                    .padding(.bottom, 5.0)
                
                Text("누구나 쉬는시간이 필요하니까.")
                        .font(.custom("Pretendard-Light", size: 13))
                .padding(.bottom)
                
                Spacer()
                
                VStack {
                    Text("팀원들을 초대할 방을 만들어 주세요.")
                        .body3()
                    
                    RoundButton(buttonType: .primary, title: "방 만들기", isButton: true) {
                        moveToCreate = true
                        makeRoomCode()
                        roomId = roomCode
                    }
                    NavigationLink(isActive: $moveToCreate) {
                        CreateMeetingRoomView(vm: vm, backToHome: $backToHome, barTitle: "방 만들기")
                    } label: { }.hidden()
                }
                .padding(.bottom)
                
                VStack {
                    Text("이미 방이 있다면 qr코드를 통해 입장해주세요.")
                        .body3()
                    RoundButton(buttonType: .outline, title: "입장하기", isButton: true) {
                        isPresentingScanner = true
                    }
                    .fullScreenCover(isPresented: $isPresentingScanner) {
                        scannerSheet
                    }
                }
                .padding(.bottom)
                
                NavigationLink(isActive: $backToHome) {
                    MeetingRoomView(vm: vm, backToHome: $backToHome)
                } label: { }.hidden()
            }
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $isFirstLaunching) {
            OnboardingView(isFirstLaunching: $isFirstLaunching)
        }
    }
    
    private func makeRoomCode() {
        let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        self.roomCode = ""
        for _ in 0 ..< 6 {
            guard let randomCharacter = str.randomElement() else { break }
            roomCode.append(randomCharacter)
        }
        
        for storeRoomCode in vm.roomIdList where self.roomCode == storeRoomCode {
            makeRoomCode()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
