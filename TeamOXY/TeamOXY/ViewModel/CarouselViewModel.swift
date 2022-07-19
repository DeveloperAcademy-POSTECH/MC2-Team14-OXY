////
////  CarouselViewModel.swift
////  TeamOXY
////
////  Created by 정재윤 on 2022/06/15.
////
//
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class CarouselViewModel: ObservableObject {
//    @Published var isCompletion: Bool = false
//    @Published var FinishTopicViewCondition: [Bool] = [false, true, false] // [카드존에 있냐?, 카드덱에 있냐?, 논의중이냐?]
//    @Published var isCardBox: Bool = true
//    @Published var isCardDeck: Bool = true
//    @Published var height: CGFloat = 0
//
//    @Published var topicTitle = ""
//    @Published var currentCardIndex = 0
////    @Published var currentTopic: Topic?
////    @Published var topicViews: [Topic] = Topic.topicViews
//    @Published var currentTime: Date?
//
//    @Published var ownNotification: Bool = true
//    @Published var userNotification: Bool = true
//    func storeTopicInformation() {
//        guard let roomId = FirebaseManager.shared.roomId else {
//            print("없어!!!!")
//            return
//        }
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
//            print("아이디 없엉")
//            return
//        }
//
//        let topicData = [
//            FirebaseConstants.uid: uid,
//            FirebaseConstants.topic: self.topicTitle,
//            FirebaseConstants.currentCardIndex: self.currentCardIndex,
//            FirebaseConstants.isCardDeck: self.isCardDeck,
//            FirebaseConstants.isCardBox: self.isCardBox,
//            FirebaseConstants.isOnCardZone: self.FinishTopicViewCondition[0],
//            FirebaseConstants.isOnCardDeck: self.FinishTopicViewCondition[1],
//            FirebaseConstants.underDiscussion: self.FinishTopicViewCondition[2],
//            FirebaseConstants.height: self.height,
//            FirebaseConstants.timestamp: Date()
//        ] as [String : Any]
//
////        self.currentTime = topicData[FirebaseConstants.timestamp] as? Date
////
////        if self.isNotification {
////            NotificationManager.shared.CardzoneNotification(isInCardZoneTime: self.currentTime ?? Date())
////        }
////        self.isNotification = false
//
//        FirebaseManager.shared.firestore
//            .collection(FirebaseConstants.rooms)
//            .document(roomId)
//            .collection(FirebaseConstants.topics)
//            .document("topic")
//            .setData(topicData) { error in
//                if let error = error {
//                    print("Failed to store topic information: \(error)")
//                    return
//                }
//
//                print("Successfully stored topic information")
//                self.fetchTopic()
//            }
//    }
//
//    func fetchTopic() {
//        guard let roomId = FirebaseManager.shared.roomId else {
//            print("없어!!!!")
//            return
//        }
//
//
//        FirebaseManager.shared.firestore
//            .collection(FirebaseConstants.rooms)
//            .document(roomId)
//            .collection(FirebaseConstants.topics)
//            .addSnapshotListener { querySnapshot, error in
//                if let error = error {
//                    print("Failed to listen for new topic: \(error)")
//                    return
//                }
//                
//                guard let change = querySnapshot?.documentChanges[0] else {
//                    print("change가 없어요")
//                    return
//                }
//
//                let data = change.document.data()
//                self.currentTopic = Topic(documentId: "topic", data: data)
//
//                guard let currentTopic = self.currentTopic else { return }
//                print("success: \(currentTopic.currentCardIndex) \(currentTopic.uid == FirebaseManager.shared.currentUser?.uid)")
//                print("\(self.FinishTopicViewCondition)")
//
//                self.topicTitle = currentTopic.topic
//                self.height = currentTopic.height
//                self.currentCardIndex = currentTopic.currentCardIndex
//
//                self.isCardDeck = currentTopic.isCardDeck
//                let finishTopicViewCondition = [self.currentTopic?.isOnCardZone ?? false, self.currentTopic?.isOnCardDeck ?? true, self.currentTopic?.underDiscussion ?? false]
//                self.FinishTopicViewCondition = finishTopicViewCondition
//                self.isCardBox = currentTopic.isCardBox
//
//
////
////                self.height = CGFloat(currentTopic.height)
////                self.width = CGFloat(currentTopic.width)
//
//
//            }
//    }
//
//    func notificateTopicToUser() {
//        if self.userNotification {
//            NotificationManager.shared.CardzoneNotification(isInCardZoneTime: Date())
//        }
//    }
//
//    func notificateTopicToMe() {
//        if self.ownNotification {
//            print("실행됐음")
//            NotificationManager.shared.CardzoneNotification(isInCardZoneTime: Date())
//        }
//    }
//
//}
