//
//  OnboardingLastPageView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/10.
//

import SwiftUI

struct OnboardingLastPageView: View {
    let imageName: String
    let title: String
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack {
            Text(title)
        .font(.custom("Pretendard-Thin", size: 24))
        .multilineTextAlignment(.center)
        .padding()
            Image(imageName)
                .padding()

                    
                    // 온보딩 완료 버튼.
                    // AppStorage의 isFirstLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
                    Button {
                        isFirstLaunching.toggle()
//                        print("hi")
                    } label: {
                        Text("시작하기")
                            .font(.custom("Pretendard-Black", size: 16))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                            .background(Color.blue)
                            .cornerRadius(28)
                    }
                    .padding()
                }
    }
}

//struct OnboardingLastPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingLastPageView()
//    }
//}
