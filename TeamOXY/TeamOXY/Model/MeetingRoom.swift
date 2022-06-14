//
//  MeetingRoom.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/14.
//

import SwiftUI

struct MeetingRoom: Codable, Identifiable {
    var id: String { documentId }
    let documentId: String
    var users: [String]
    var topics: [String]
    var reactions: [String]
    
    init(documentId: String, users: [String], topics: [String], reactions: [String]) {
        self.documentId = documentId
        self.users = users
        self.topics = topics
        self.reactions = reactions
    }
}
