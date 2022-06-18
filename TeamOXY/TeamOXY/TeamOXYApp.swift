//
//  TeamOXYApp.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/03.
//

import SwiftUI
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
   // 앱이 켜졌을때
   let gcmMessageIDKey = "gcm.message_id"
    
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

       // Use Firebase library to configure APIs
       // 파이어베이스 설정
       FirebaseApp.configure()

       // 원격 알림 등록
       if #available(iOS 10.0, *) {
         // For iOS 10 display notification (sent via APNS)
         UNUserNotificationCenter.current().delegate = self

         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
         UNUserNotificationCenter.current().requestAuthorization(
           options: authOptions,
           completionHandler: { _, _ in }
         )
       } else {
         let settings: UIUserNotificationSettings =
           UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
         application.registerUserNotificationSettings(settings)
       }

       application.registerForRemoteNotifications()

       // 메세징 델리겟
       Messaging.messaging().delegate = self


       // 푸시 포그라운드 설정
       UNUserNotificationCenter.current().delegate = self

       return true
   }

   // fcm 토큰이 등록 되었을 때
   func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       Messaging.messaging().apnsToken = deviceToken
   }

   // remote notification을 listen && alert the app
       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

           if let messageID = userInfo[gcmMessageIDKey] {
               print("Message ID: \(messageID)")
           }

           print(userInfo)

           completionHandler(UIBackgroundFetchResult.newData)
       }

}

extension AppDelegate : MessagingDelegate {
   // fcm 등록 토큰을 받았을 때
   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        let deviceToken: [String:String] = ["token":fcmToken ?? ""]

       print("AppDelegate - 파베 토큰을 받았다.")
       print("AppDelegate - Firebase registration token: \(String(describing: fcmToken))")

       TokenModel.shared.token = fcmToken ?? ""
   }
}

@available(ios 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message Id: \(messageID)")
        }
        
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([[.banner, .badge, .sound]])
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID from userNotificationCenter didReceive: \(messageID)")
        }

        print(userInfo)

        completionHandler()
    }
}

@main
struct TeamOXYApp: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

   var body: some Scene {
       WindowGroup {
           HomeView()
       }
   }
}
