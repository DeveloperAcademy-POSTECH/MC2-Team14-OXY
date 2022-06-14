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

class User: Codable, Identifiable {
    let uid: String
    let nickname: String?
    let documentId: String

    init(data: [String : Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.documentId = data["documentId"] as? String ?? ""
        self.nickname = data["nickname"] as? String ?? ""
    }
}
