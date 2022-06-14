//
//  TimerStatus.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/12.
//

import SwiftUI

enum NotificationStatus {
    case notificationOn
    case notificationOff
    
    var buttonText: String {
        switch self {
        case .notificationOn:
            return "알람끄기"
        case .notificationOff:
            return "알람켜기"
        }
    }
    
    var buttonImgName: String {
        switch self {
        case .notificationOn:
            return "turnOffBeep"
        case .notificationOff:
            return "turnOnBeep"
        }
    }
}
