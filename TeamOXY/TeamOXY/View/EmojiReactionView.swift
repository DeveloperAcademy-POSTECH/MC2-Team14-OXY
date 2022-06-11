//
//  EmojiReactionView.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/10.
//

import SwiftUI
import ConfettiSwiftUI

struct EmojiReactionView: View {
    
    let emojis = ["🤔","👎","👍","🤩","🫠","🔥","❤️","😱","🤭","🥱","👀","✅","🙅","🎉","😂"]
    
    @State private var counter = 1
    @State private var emojiString = ""
    
    var body: some View {
        NavigationView {
            
            
            ZStack(alignment: .center){
                
                VStack{
                    
                    Rectangle()
                        .padding()
                        .frame(height: 400)
                        .padding(.top, 15)
                        .foregroundColor(.white)
                        .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
                        .onTapGesture {
                            counter += 1
                        }
                    
                    Text("누군가 쉬는 시간을 제안했습니다.")
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    Text("아래 아이콘을 탭해서 반응해 보세요.")
                        .fontWeight(.bold)
                        .padding(.top, 4)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(emojis, id: \.self) { emoji in
                                ZStack(alignment: .center) {
                                    
                                    Circle()
                                        .foregroundColor(.white)
                                        .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
                                    
                                    Button(action: {
                                        
                                        counter += 1
                                        emojiString = emoji
                                        print(emojiString)
                                        print(counter)
                                        
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                            counter = 0
//                                        }
                                        
//                                        counter = 0

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
                ConfettiCannon(counter: $counter, num: 5, confettis: counter > 3 ? [.text("🫠")] : [.text("🫠")], radius: 300.0)
            }
        }
    }
}

struct EmojiReactionView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiReactionView()
    }
}
