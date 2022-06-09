//
//  HomeView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/09.
//

import SwiftUI

struct WhiteButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 350, height: 55)
            .foregroundColor(.PrimaryBlue)
            .border(Color.PrimaryBlue, width: 1)
            .clipShape(Capsule())
        
    }
}
struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 350, height: 55)
            .background(Color.PrimaryBlue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                HStack {
                    Text("누구나\n쉬는시간이\n필요하니까")
                        .font(.system(size: 40, weight: .black))
                    Spacer()
                }
                .padding(.horizontal, 96.0)
                Image("Logo")
                Spacer()
                Text("팀원들을 초대할 방을 만들어 주세요.")
                Button("방 만들기") {
                            print("Button pressed!")
                        }
                        .buttonStyle(BlueButton())
                Text("이미 방이 있다면 qr코드를 통해 입장해주세요.")
                Button("입장하기") {
                            print("Button pressed!")
                        }
                        .buttonStyle(WhiteButton())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
