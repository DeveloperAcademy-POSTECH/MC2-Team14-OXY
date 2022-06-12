//
//  FinishTopicView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/12.
//

import SwiftUI

struct FinishTopicView: View {
    
    @ObservedObject var viewModel: CompletionViewModel
    
    
    @Binding var FinishTopicViewCondition: [Bool]
    
    var body: some View {
        ZStack(alignment: .center) {
            
            VStack {
                Text("🕰⏰🕰⏰")
                    .font(.system(size: 58))
                    .padding(.bottom, 20)
                Text("쉬는 시간을\n 설정하시겠습니까?")
                    .font(.custom("Pretendard-Light", size: 24))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                HStack {
                    Button(action: {
                        // FinishTopicView뜨는 조건 초기화
                        FinishTopicViewCondition = []
                        // 로티 끄기
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.isCompletion = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                            viewModel.isCompletion = false
                        }
                        
                        
                    }) {
                        Circle()
                            .stroke(Color("PrimaryBlue"))
                            .frame(width: 58, height: 58, alignment: .center)
                            .overlay(Text("아니요").font(.custom("Pretendard-Bold", size: 14)).foregroundColor(Color("PrimaryBlue")))
                    }
                    Spacer()
                    Button(action: {
                        // FinishTopicView뜨는 조건 초기화
                        FinishTopicViewCondition = []
                    }) {
                        Circle()
                            .fill(Color("PrimaryBlue"))
                            .frame(width: 58, height: 58, alignment: .center)
                            .overlay(Text("네").font(.custom("Pretendard-Bold", size: 14)).foregroundColor(.white))
                    }
                }
                .padding(.horizontal, 40)
            }
            .padding(.horizontal, 62)
            
        }
    }
}
//
//struct FinishTopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinishTopicView()
//    }
//}
