//
//  NotificationManager.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/06/17.
//

import SwiftUI
import UserNotifications

struct NotificationManager {
    
    static let shared = NotificationManager()
    
    func TimeIntervalNotification(title: String, subtitle: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
//        content.badge =
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    
    func CardzoneNotification(isInCardZoneTime: Date) {
        // isInCardZoneTime은 파베로부터 받아온 시간
        let content = UNMutableNotificationContent()
        content.title = "누군가 쉬고 싶어 합니다!"
        content.subtitle = "쉼카드를 확인하고 반응해주세요.🥳"
        content.sound = .default
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm ss"
        let time = formatter.string(from: isInCardZoneTime)
        let timeArr = time.components(separatedBy: " ").map{ (value:String) -> Int in
            return Int(value) ?? 0
        }
        let hour = Calendar.autoupdatingCurrent.component(.hour, from: isInCardZoneTime)
        
        var notificationTime = DateComponents()
        notificationTime.hour = hour
        notificationTime.minute = timeArr[0]
        notificationTime.second = timeArr[1] + 1
        // 어떤 유저가 cardzone에 안건을 던져서 저장된 시간과, 그 안건의 시간정보를 다른 유저사이의 시간 딜레이 때문에 몇초 딜레이 시켜야할 것 같음
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}
