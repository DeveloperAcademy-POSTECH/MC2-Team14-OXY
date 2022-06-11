//
//  OnboardingView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/10.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
                    // 페이지 1: 앱 소개
                    OnboardingPageView(
                        imageName: "Onboarding1",
                        title: "쉼 카드를 올려서\n쉬는 시간을 제안해보세요."
                    )
                    
                    // 페이지 2: 쓰기 페이지 안내
                    OnboardingPageView(
                        imageName: "Onboarding2",
                        title: "누군가 쉬는 시간을 제안하면\n실시간으로 반응 할 수 있어요."
                    )
                    
                    // 페이지 3: 읽기 페이지 안내 + 온보딩 완료
                    OnboardingLastPageView(
                        imageName: "Onboarding3",
                        title: "쉼 카드를 아래로 내려서\n논의을 끝낼 수 있어요."
//                        ,
//                        isFirstLaunching: $isFirstLaunching
                    )
                }
                .tabViewStyle(PageTabViewStyle())

        
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
