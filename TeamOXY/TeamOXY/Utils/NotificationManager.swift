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
    
    func TimeIntervalNotification(time: Int, title: String, subtitle: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
//        content.badge =
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}
