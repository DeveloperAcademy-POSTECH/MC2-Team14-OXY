//
//  OnboardingPageView.swift
//  TeamOXY
//
//  Created by 이성수 on 2022/06/10.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
                    Image(systemName: imageName)
                        .font(.system(size: 100))
                        .padding()
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Text(subtitle)
                        .font(.title2)
                }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(
            imageName: "note.text.badge.plus",
            title: "쓰기 탭",
            subtitle: "이 앱은 개인 메모장으로 쓸 수 있어요"
        )
    }
}
