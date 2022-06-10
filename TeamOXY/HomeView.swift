//
//  HomeView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/09.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
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
                Button(action: {
                            print("Button pressed!")
//                    print 대신에 NavigationLink 써서 방만들기에 연결하기
                        }){
                            Text("🏠  방 만들기")
                                .font(.custom("Pretendard-Black", size: 16))
                                .foregroundColor(.white)
                                .frame(width: 350, height: 55)
                                        .background(Color.PrimaryBlue)
                                        .clipShape(Capsule())
                                
                        }
                        .padding(.bottom)
                Text("이미 방이 있다면 qr코드를 통해 입장해주세요.")
                    .font(.custom("Pretendard-SemiBold", size: 12))
                Button(action: {
                            print("Button pressed!")
//                    print 대신에 NavigationLink 써서 입장하기QR에 연결하기
                        }){
                            Text("🚪  입장하기")
                                .font(.custom("Pretendard-Black", size: 16))
                                .foregroundColor(.PrimaryBlue)
                                .frame(width: 350, height: 55)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(Color.PrimaryBlue, lineWidth: 1)
                                    
                                )
                        }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
