//
//  EmojiReactionView.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/10.
//

import SwiftUI
import ConfettiSwiftUI

struct EmojiReactionView: View {
    
    let emojis = ["🤔","👎","👍","🤩","🫠", "🔥","❤️","😱","🤭","🥱","👀","✅","🙅","🎉","😂"]

    
    @ObservedObject var viewModel = EmojieViewModel()
    
    var body: some View {
            ZStack(alignment: .center){
                VStack{
                   Spacer()
                        .frame(height:UIScreen.main.bounds.height / 1.8)
                    
                    // 아래로 내리는 화살표
                    ArrowAnimationView()
                        .rotationEffect(.degrees(90))
                        .padding(.top, -5)
                        
                    // 화면 중간 텍스트
                    middleTextView()
                        .padding(.top, 10)
                
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(emojis, id: \.self) { emoji in
                                ZStack(alignment: .center) {
                                    
                                    Circle()
                                        .foregroundColor(.white)
                                        .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
                                    
                                    Button(action: {
                                        
                                        viewModel.emojiCountPlus(emoji)

                                    }){
                                        Text(emoji)
                                            .font(.system(size: 35))
                                            .padding(8)
                                    }
                                }
                                    .padding(4)
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("익명의 원숭이 방 6")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
   
                        }) {
                            Image(systemName: "chevron.backward")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {

                        }) {
                            Image(systemName: "qrcode.viewfinder")
                                .imageScale(.large)
                        }
                    }
                })
                
                ZStack {
                    ConfettiCannon(counter: $viewModel.emojiCount_1, num: 5, confettis: [.text("🤔")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_2, num: 5, confettis: [.text("👎")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_3, num: 5, confettis: [.text("👍")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_4, num: 5, confettis: [.text("🤩")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_5, num: 5, confettis: [.text("🫠")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_6, num: 5, confettis: [.text("🔥")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_7, num: 5, confettis: [.text("❤️")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_8, num: 5, confettis: [.text("😱")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_9, num: 5, confettis: [.text("🤭")], confettiSize: 30, radius: 300.0)
                }
                
                
                    ConfettiCannon(counter: $viewModel.emojiCount_10, num: 5, confettis: [.text("🥱")], confettiSize: 30, radius: 300.0)
                
                    ConfettiCannon(counter: $viewModel.emojiCount_11, num: 5, confettis: [.text("👀")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_12, num: 5, confettis: [.text("✅")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_13, num: 5, confettis: [.text("🙅")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_14, num: 5, confettis: [.text("🎉")], confettiSize: 30, radius: 300.0)
                    
                    ConfettiCannon(counter: $viewModel.emojiCount_15, num: 5, confettis: [.text("😂")], confettiSize: 30, radius: 300.0)

            }
    }
}

struct EmojiReactionView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiReactionView()
    }
}


struct middleTextView : View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("누군가")
                    .font(.custom("Pretendard-Bold", size: 12))
                
                Text("쉬는 시간")
                    .foregroundColor(Color.PrimaryBlue)
                    .font(.custom("Pretendard-Bold", size: 12))
                
                Text("을 제안했습니다.")
                    .font(.custom("Pretendard-Bold", size: 12))
                    .padding(.leading, -7)
            }
            
            Text("아래 아이콘을 탭해서 반응해 보세요.")
                .font(.custom("Pretendard-Bold", size: 12))
        }
    }
}
