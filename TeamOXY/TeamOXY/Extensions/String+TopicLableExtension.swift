//
//  String+TopicLableExtension.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/16.
//

import SwiftUI

extension String {
    var topicImageLabel: String {
        switch self {
        case "당장 쉬자":
            return "Card1"
        case "커피 먹자":
            return "Card2"
        case "딴데 가자":
            return "Card3"
        case "각자 쉬자":
            return "Card4"
        case "집에 가자":
            return "Card5"
        default:
            return "xmark"
        }
    }
}
