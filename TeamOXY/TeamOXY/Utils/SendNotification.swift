//
//  SendNotification.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/15.
//

import SwiftUI
import FirebaseMessaging
import FirebaseFirestore
import FirebaseFirestoreSwift

class PushNotification: ObservableObject {
    var serverKey: String { (Bundle.main.infoDictionary?["FIREBASE_SERVER_KEY"] as? String) ?? "" }
    
    func sendMessageToDevice(token: String, data: [String: String]) {
        // Simple Logic
        // Usinbg Firebase API to send Push Notification to another device using token
        // Without haivng server...
        
        // Converting That to URL Request Format...
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {
            print("Failed to ")
            return
        }
        
        let json: [String: Any] = [
            "to": token,
            "notification": [
                "title": data["title"],
                "body": data["body"]
            ],
            "data": [
                // Data to be Sent...
                // Dont pass empty or remove the block..
                "user_name": data["uid"]
            ]
        ]
        
        //URL Reequest...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Converting json Dict to JSON
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        // Setting Content Type and Authorization
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Authorization key will be Your Server Key....
        request.setValue("key=\(self.serverKey)", forHTTPHeaderField: "Authorization")
        
        // Passing request using URL session.
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, err in
            if let err = err {
                print("Failed to send message: \(err)")
                return
            }
            
            // Else Success
            // Clearing Fields..
            // Or Your Action when message sends...
            print("Successfully send message")
        }
        .resume()  // task가 유예되었을 때 계속 진행하라는 메소드
    }
}
