//
//  Reaction.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Reaction: Codable, Identifiable {
    var id: String { documentId }
    let fromId, toId, reaction: String
    let timestamp: Timestamp
    let documentId: String
    
    init(documentId: String, data: [String : Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.reaction = data["reaction"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
