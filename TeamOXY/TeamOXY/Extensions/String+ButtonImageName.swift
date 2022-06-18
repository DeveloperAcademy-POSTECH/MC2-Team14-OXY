//
//  String+ButtonImageName.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/10.
//

import SwiftUI

extension String {
    func buttonImageLabel() -> String {
        switch self {
        case "방 만들기", "쉬는시간 시작":
            return "🏡"
        case "입장하기":
            return "🚪"
        case "알림꺼짐":
            return "turnOffBeep"
        case "알림켜짐":
            return "turnOnBeep"
        default:
            return ""
        }
    }
}
