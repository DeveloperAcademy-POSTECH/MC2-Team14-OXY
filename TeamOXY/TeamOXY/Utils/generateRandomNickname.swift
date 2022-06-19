//
//  RandomNicknameFunciton.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import SwiftUI

func generateRandomNickname(_ nickname: String? = nil) -> String {
    let nicknames: [String] = ["신나는 이쉼이", "행복한 전쉼이", "신나는 전쉼이", "행복한 이쉼이", "즐거운 이쉼이", "즐거운 전쉼이", "심심한 이쉼이", "심심한 전쉼이", "힘든 이쉼이", "힘든 전쉼이", "슬픈 이쉼이", "슬픈 전쉼이", "짜릿한 이쉼이", "짜릿한 전쉼이", "우울한 이쉼이", "우울한 전쉼이", "그냥그런 이쉼이"]
    
    guard let nickname = nickname else {
        return nicknames.randomElement() ?? ""
    }

    let startIndex = nickname.index(nickname.startIndex, offsetBy: 0)
    let endIndex = nickname.index(nickname.startIndex, offsetBy: 3)
    let manualNickname = nickname[startIndex ..< endIndex]

    return "익명의 " + (nickname.count > 3 ? String(manualNickname) : nickname)
}

