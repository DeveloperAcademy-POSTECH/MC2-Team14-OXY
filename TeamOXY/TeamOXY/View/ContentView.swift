//
//  ContentView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/03.
//

import SwiftUI

let emojis = ["🤔","👎","👍","🤩","🫠","🔥","❤️","😱","🤭","🥱","👀","✅","🙅","🎉","😂"]


struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack{
                
                VStack{
                    
                    Rectangle()
                        .padding()
                        .frame(height: 400)
                        .padding(.top, 15)
                        .foregroundColor(.white)
                        .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
                    
                    Text("누군가 쉬는 시간을 제안했습니다.")
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    Text("아래 아이콘을 탭해서 반응해 보세요.")
                        .fontWeight(.bold)
                        .padding(.top, 4)
                    
                    reactionEmojiView()
                    
                }
                .navigationTitle("익명의 원숭이 방 6")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
    //                                                addTask()
                        }) {
                            Image(systemName: "chevron.backward")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
    //                                                removeTask()
                        }) {
                            Image(systemName: "qrcode.viewfinder")
                                .imageScale(.large)
                        }
                    }
                })
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct reactionEmojiView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    emojiCardView(emoji: emoji)
                        .padding(4)
                }
            }
            .padding()
        }
    }
}

struct emojiCardView: View {
    
    var emoji : String
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
            
            Button(action: {
                reactionAnimation(emoji)
            }){
                Text(emoji)
                    .font(.system(size: 35))
                    .padding(8)
            }
        }
    }
}


func reactionAnimation(_ emoji : String) {
    print(emoji)
}
