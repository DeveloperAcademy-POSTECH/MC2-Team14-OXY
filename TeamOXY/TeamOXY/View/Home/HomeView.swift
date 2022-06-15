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
    
    @State private var isPresentingScanner = false
    @State private var scannedCodeUrl = ""
    @State var backToHome = false
    
    var scannerSheet: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr]) { result in
                if case let .success(code) = result {
                    self.scannedCodeUrl = code.string
                    print(self.scannedCodeUrl)
                    self.isPresentingScanner = false
                    self.backToHome = true
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
                
                HStack {
                    Text("누구나\n쉬는시간이\n필요하니까.")
                        .font(.custom("Pretendard-Light", size: 34))
                    Spacer()
                }
                .padding(.leading, 78)
                .padding(.bottom)
                
                Image("Logo")
                
                Spacer()
                
                VStack {
                    Text("팀원들을 초대할 방을 만들어 주세요.")
                        .body3()
                    
                    NavigationLink(isActive: $backToHome) {
                        CreateMeetingRoomView(barTitle: "방 만들기", backToHome: $backToHome)
                    } label: {
                        RoundButton(buttonType: .primary, title: "방 만들기", isButton: false) { }
                    }
                }
                .padding(.bottom)
                
                VStack {
                    Text("이미 방이 있다면 qr코드를 통해 입장해주세요.")
                        .body3()
                    RoundButton(buttonType: .outline, title: "입장하기", isButton: true) {
                        isPresentingScanner = true
                    }
                    .fullScreenCover(isPresented: $isPresentingScanner) {
                        self.scannerSheet
                    }
                }
                .padding(.bottom)
            }
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $isFirstLaunching) {
            OnboardingView(isFirstLaunching: $isFirstLaunching)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
