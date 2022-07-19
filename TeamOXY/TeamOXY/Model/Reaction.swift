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
    @DocumentID var id: String?
    let fromId, toId, reaction: String
    let timestamp: Date
}
