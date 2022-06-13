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
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Pretendard-Thin", size: 24))
                .multilineTextAlignment(.center)
                .padding()
            
            Image(imageName)
                .padding()
            
            Spacer()
                .frame(height: 70)
            
            

        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(
            imageName: "Onboarding1",
            title: "쉼 카드를 올려서\n쉬는 시간을 제안해보세요."
        )
    }
}
