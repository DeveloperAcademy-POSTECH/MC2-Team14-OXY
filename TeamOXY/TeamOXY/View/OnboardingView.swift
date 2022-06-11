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
                        imageName: "person.3.fill",
                        title: "놀라운 개발자 커뮤니티",
                        subtitle: "질문을 던지고, 다른 사람의 답변을 확인하세요"
                    )
                    
                    // 페이지 2: 쓰기 페이지 안내
                    OnboardingPageView(
                        imageName: "note.text.badge.plus",
                        title: "쓰기 탭",
                        subtitle: "이 앱은 개인 메모장으로도 쓸 수 있어요"
                    )
                    
                    // 페이지 3: 읽기 페이지 안내 + 온보딩 완료
                    OnboardingLastPageView(
                        imageName: "eyes",
                        title: "읽기 탭",
                        subtitle: "시행착오를 정리해서 공유하고, 다른 개발자들의 인사이트를 얻으세요"
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
