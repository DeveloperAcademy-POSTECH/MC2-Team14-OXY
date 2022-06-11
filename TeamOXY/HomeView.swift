//
//  HomeView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/09.
//

import SwiftUI


struct HomeView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
//    온보딩 페이지를 앱 설치 후 최초 실행할때만 띄우는 변수, @AppStorage에 저장되어 앱 종료 후에도 유지시킨다.
    
    var body: some View {
        
        Text("App Main")
            // 앱 최초 구동 시 전체화면으로 OnboardingTabView 띄우기
//            .fullScreenCover(isPresented: $isFirstLaunching)
        
            .fullScreenCover(isPresented: Binding.constant(true)) {
                OnboardingView(isFirstLaunching: $isFirstLaunching)
            }
        
        NavigationView{
            VStack {
                Spacer()
                
                HStack {
                    Text("누구나\n쉬는시간이\n필요하니까.")
                        .font(.custom("Pretendard-Black", size: 40))
                    Spacer()
                }
                .padding(.horizontal, 96.0)
                
                Image("Logo")
                
                Spacer()
                
                Text("팀원들을 초대할 방을 만들어 주세요.")
                    .font(.custom("Pretendard-SemiBold", size: 12))
                
                Button {
                    
                } label: {
                    HStack{
                        Image("CreateRoom")
                        Text("방 만들기")
                    }
                    .font(.custom("Pretendard-Black", size: 16))
                    .foregroundColor(.white)
                    .frame(width: 350, height: 55)
                    .background(Color.PrimaryBlue)
                    .clipShape(Capsule())
                }
                .padding(.bottom)
                
                Text("이미 방이 있다면 qr코드를 통해 입장해주세요.")
                    .font(.custom("Pretendard-SemiBold", size: 12))
                Button {
                    
                } label: {
                    HStack{
                        Image("JoinToRoom")
                        Text("입장하기")
                    }
                    .font(.custom("Pretendard-Black", size: 16))
                    .foregroundColor(.PrimaryBlue)
                    .frame(width: 350, height: 55)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.PrimaryBlue, lineWidth: 1))
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
