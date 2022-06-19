//
//  Topic.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/13.
//
//
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//struct Topic: Codable, Identifiable {
////    var id: String { documentId }
//    @DocumentID var id: String?
////    let documentId: String
//    let topic: String
//    let currentCardIndex: Int
//    let isCardDeck: Bool
//    let isOnCardZone, isOnCardDeck, underDiscussion: Bool
//    let width: CGFloat
//    let height: CGFloat
//    let timestamp: Date
//
//    var viewState: CGSize {
//        return CGSize(width: self.width, height: self.height)
//    }
//
//    var finishTopicViewCondition: [Bool] {
//        return [self.isOnCardZone, self.isOnCardDeck, self.underDiscussion]
//    }
//
////    init(documentId: String, data: [String: Any]) {
////        self.documentId = documentId
////        self.fromId = data["fromId"] as? String ?? ""
////        self.toId = data["toId"] as? String ?? ""
////        self.topicTitle = data["topicTitle"] as? String ?? ""
////        self.timestamp = data["timestamp"] as? Date ?? Date(date: Date())
////    }
//}

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Topic: Identifiable, Equatable {
    var id: String { documentId }
    let documentId: String
    let uid: String?
    var topic: String
    var currentCardIndex: Int
    var isCardDeck, isCardBox: Bool
    var isOnCardZone, isOnCardDeck, underDiscussion: Bool
    var height: CGFloat
    var timestamp: Date
    
    var finishTopicViewCondition: [Bool] {
        return [self.isOnCardZone, self.isOnCardDeck, self.underDiscussion ]
    }
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.uid = data["uid"] as? String? as? String ?? ""
        self.topic = data["topic"] as? String ?? ""
        self.currentCardIndex = data["currentCardIndex"] as? Int ?? 0
        self.isCardDeck = data["isCardDeck"] as? Bool ?? true
        self.isCardBox = data["isCardBox"] as? Bool ?? true
        self.isOnCardZone = data["isOnCardZone"] as? Bool ?? false
        self.isOnCardDeck = data["isOnCardDeck"] as? Bool ?? true
        self.underDiscussion = data["underDiscussion"] as? Bool ?? false
        self.height = data["height"] as? CGFloat ?? 0
        self.timestamp = data["timestamp"] as? Date ?? Date()
    }
}


extension Topic {
    static let topicViews: [Topic] = [
        Topic(documentId: "당장 쉬자", data: [
            FirebaseConstants.uid: "",
            FirebaseConstants.topic: "당장 쉬자",
            FirebaseConstants.currentCardIndex: 0,
            FirebaseConstants.isCardDeck: true,
            FirebaseConstants.isOnCardZone: false,
            FirebaseConstants.isOnCardDeck: true,
            FirebaseConstants.underDiscussion: false,
            FirebaseConstants.height: 0,
            FirebaseConstants.timestamp: Date()
        ]),
        Topic(documentId: "커피 먹자", data: [
            FirebaseConstants.uid: "",
            FirebaseConstants.topic: "커피 먹자",
            FirebaseConstants.currentCardIndex: 1,
            FirebaseConstants.isCardDeck: true,
            FirebaseConstants.isOnCardZone: false,
            FirebaseConstants.isOnCardDeck: true,
            FirebaseConstants.underDiscussion: false,
            FirebaseConstants.height: 0,
            FirebaseConstants.timestamp: Date()
        ]),
        Topic(documentId: "딴데 가자", data: [
            FirebaseConstants.uid: "",
            FirebaseConstants.topic: "딴데 가자",
            FirebaseConstants.currentCardIndex: 2,
            FirebaseConstants.isCardDeck: true,
            FirebaseConstants.isOnCardZone: false,
            FirebaseConstants.isOnCardDeck: true,
            FirebaseConstants.underDiscussion: false,
            FirebaseConstants.height: 0,
            FirebaseConstants.timestamp: Date()
        ]),
        Topic(documentId: "각자 쉬자", data: [
            FirebaseConstants.uid: "",
            FirebaseConstants.topic: "각자 쉬자",
            FirebaseConstants.currentCardIndex: 3,
            FirebaseConstants.isCardDeck: true,
            FirebaseConstants.isOnCardZone: false,
            FirebaseConstants.isOnCardDeck: true,
            FirebaseConstants.underDiscussion: false,
            FirebaseConstants.height: 0,
            FirebaseConstants.timestamp: Date()
        ]),
        Topic(documentId: "집에 가자", data: [
            FirebaseConstants.uid: "",
            FirebaseConstants.topic: "집에 가자",
            FirebaseConstants.currentCardIndex: 4,
            FirebaseConstants.isCardDeck: true,
            FirebaseConstants.isOnCardZone: false,
            FirebaseConstants.isOnCardDeck: true,
            FirebaseConstants.underDiscussion: false,
            FirebaseConstants.height: 0,
            FirebaseConstants.timestamp: Date()
        ])
    ]
}

