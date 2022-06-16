//
//  RandomNicknameFunciton.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import SwiftUI

func generateRandomNickname(_ nickname: String? = nil) -> String {
    let nicknames: [String] = ["익명의 원숭이", "익명의 코끼리", "익명의 임팔라", "익명의 앵무새", "익명의 호랑이", "익명의 거북이", "익명의 기린", "익명의 고양이", "익명의 한우", "익명의 토끼", "익명의 코뿔소", "익명의 비둘기", "익명의 족제비", "익명의 너구리", "익명의 강아지", "익명의 여우", "익명의 늑대"]
    
    guard let nickname = nickname else {
        return nicknames.randomElement() ?? ""
    }

    let startIndex = nickname.index(nickname.startIndex, offsetBy: 0)
    let endIndex = nickname.index(nickname.startIndex, offsetBy: 3)
    let manualNickname = nickname[startIndex ..< endIndex]

    return "익명의 " + (nickname.count > 3 ? String(manualNickname) : nickname)
}

