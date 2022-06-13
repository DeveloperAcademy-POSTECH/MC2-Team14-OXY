//
//  Topic.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Topic: Codable, Identifiable {
    var id: String { documentId }
    let documentId: String
    let fromId, toId, topicTitle: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.topicTitle = data["topicTitle"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
