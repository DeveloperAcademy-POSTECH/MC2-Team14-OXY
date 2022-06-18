//
//  User.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    
    let uid: String
    let nickname: String?
    let fcmtoken: String?
    
    let isNotificationOn: Bool

//    init(data: [String : Any]) {
//        self.uid = data["uid"] as? String ?? ""
//        self.nickname = data["nickname"] as? String ?? ""
//    }
}
