//
//  String+IndexExtension.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/07/19.
//

import Foundation

extension Int {
    var indexToString: String {
        switch self {
        case 0:
            return "당장쉬자"
        case 1:
            return "커피먹자"
        case 2:
            return "딴데가자"
        case 3:
            return "각자쉬자"
        case 4:
            return "집에가자"
        default:
            return ""
        }
    }
}
