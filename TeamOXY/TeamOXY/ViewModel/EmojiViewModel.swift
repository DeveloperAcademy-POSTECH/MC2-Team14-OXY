//
//  EmojiViewModel.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/12.
//

import SwiftUI

class EmojieViewModel : ObservableObject{
    @Published var emojiCount_1 : Int
    @Published var emojiCount_2 : Int
    @Published var emojiCount_3 : Int
    @Published var emojiCount_4 : Int
    @Published var emojiCount_5 : Int
    @Published var emojiCount_6 : Int
    @Published var emojiCount_7 : Int
    @Published var emojiCount_8 : Int
    @Published var emojiCount_9 : Int
    @Published var emojiCount_10 : Int
    @Published var emojiCount_11 : Int
    @Published var emojiCount_12 : Int
    @Published var emojiCount_13 : Int
    @Published var emojiCount_14 : Int
    @Published var emojiCount_15 : Int
    
    init() {
        self.emojiCount_1 = 0
        self.emojiCount_2 = 0
        self.emojiCount_3 = 0
        self.emojiCount_4 = 0
        self.emojiCount_5 = 0
        self.emojiCount_6 = 0
        self.emojiCount_7 = 0
        self.emojiCount_8 = 0
        self.emojiCount_9 = 0
        self.emojiCount_10 = 0
        self.emojiCount_11 = 0
        self.emojiCount_12 = 0
        self.emojiCount_13 = 0
        self.emojiCount_14 = 0
        self.emojiCount_15 = 0
        
    }
    
    func emojiCountPlus (_ emoji : String) {
        switch emoji {
        case "🤔" :
            self.emojiCount_1 += 1
            print(emojiCount_1)
            
        case "👎" :
            self.emojiCount_2 += 1
            print(emojiCount_2)
            
        case "👍" :
            self.emojiCount_3 += 1
            print(emojiCount_3)
            
        case "🤩" :
            self.emojiCount_4 += 1
            print(emojiCount_4)
            
        case "🫠" :
            self.emojiCount_5 += 1
            print(emojiCount_5)
            
        case "🔥" :
            self.emojiCount_6 += 1
            print(emojiCount_6)
            
        case "❤️" :
            self.emojiCount_7 += 1
            print(emojiCount_7)
            
        case "😱" :
            self.emojiCount_8 += 1
            print(emojiCount_8)
            
        case "🤭" :
            self.emojiCount_9 += 1
            print(emojiCount_9)
            
        case "🥱" :
            self.emojiCount_10 += 1
            print(emojiCount_10)
            
        case "👀" :
            self.emojiCount_11 += 1
            print(emojiCount_11)
        
        case "✅" :
            self.emojiCount_12 += 1
            print(emojiCount_12)
            
        case "🙅" :
            self.emojiCount_13 += 1
            print(emojiCount_13)
            
        case "🎉" :
            self.emojiCount_14 += 1
            print(emojiCount_14)
                  
        case "😂" :
            self.emojiCount_15 += 1
            print(emojiCount_15)
            
        default :
            print("잘못 눌렀습니다.")
        }
    }
}
