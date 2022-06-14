//
//  FinishTopicView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/12.
//

import SwiftUI

struct FinishTopicView: View {
    
    @ObservedObject var viewModel: CompletionViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            
            VStack {
                Text("🕰⏰🕰⏰")
                    .font(.system(size: 58))
                    .padding(.bottom, UIScreen.screenHeight * 0.022)
                Text("쉬는 시간을\n 설정하시겠습니까?")
                    .font(.custom("Pretendard-Bold", size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, UIScreen.screenHeight * 0.022)
                HStack {
                    Button(action: {
                        // FinishTopicView뜨는 조건 초기화
                        viewModel.FinishTopicViewCondition = [false, true, false]
                        // 로티 on/off
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.isCompletion = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                            viewModel.isCompletion = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                            viewModel.isCardBox = true
                        }
                    }) {
                        Circle()
                            .stroke(Color("PrimaryBlue"))
                            .frame(width: UIScreen.screenWidth * 0.148, height: UIScreen.screenWidth * 0.148, alignment: .center)
                            .overlay(Text("아니요").font(.custom("Pretendard-Bold", size: 14)).foregroundColor(Color("PrimaryBlue")))
                    }
                    Spacer()
                    Button(action: {
                        // FinishTopicView뜨는 조건 초기화
                        viewModel.FinishTopicViewCondition = [false, true, false]
                    }) {
                        Circle()
                            .fill(Color("PrimaryBlue"))
                            .frame(width: UIScreen.screenWidth * 0.148, height: UIScreen.screenWidth * 0.148,  alignment: .center)
                            .overlay(Text("네").font(.custom("Pretendard-Bold", size: 14)).foregroundColor(.white))
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth * 0.102)
            }
            .padding(.horizontal, UIScreen.screenWidth * 0.158)
            
        }
    }
}
//
//struct FinishTopicView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinishTopicView()
//    }
//}
