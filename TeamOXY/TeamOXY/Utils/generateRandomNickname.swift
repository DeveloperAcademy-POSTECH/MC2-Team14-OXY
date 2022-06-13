//
//  RandomNicknameFunciton.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import SwiftUI

func generateRandomNickname(_ nickname: String?) -> String {
    let nicknames: [String] = ["익명의 원숭이", "익명의 코끼리", "익명의 임팔라", "익명의 앵무새", "익명의 호랑이", "익명의 거북이"]
    
    guard let nickname = nickname else {
        return nicknames.randomElement() ?? ""
    }

    let startIndex = nickname.index(nickname.startIndex, offsetBy: 0)
    let endIndex = nickname.index(nickname.startIndex, offsetBy: 3)
    let manualNickname = nickname[startIndex ..< endIndex]

    return "익명의 " + (nickname.count > 3 ? String(manualNickname) : nickname)
}

