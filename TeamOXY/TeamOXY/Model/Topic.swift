//
//  Topic.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Topic: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    var topic: String
    var currentCardIndex: Int
    var timestamp: Date = Date()
}


extension Topic {
    static let topicViews: [Topic] = [
        Topic(topic: "당장쉬자", currentCardIndex: 0),
        Topic(topic: "커피먹자", currentCardIndex: 1),
        Topic(topic: "딴데가자", currentCardIndex: 2),
        Topic(topic: "각자쉬자", currentCardIndex: 3),
        Topic(topic: "집에가자", currentCardIndex: 4),
    ]
}

