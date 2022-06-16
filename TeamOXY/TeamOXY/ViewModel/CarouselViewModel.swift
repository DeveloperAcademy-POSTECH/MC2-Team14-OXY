//
//  CarouselViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/15.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class CarouselViewModel: ObservableObject {
    @Published var isCompletion: Bool = false
    @Published var FinishTopicViewCondition: [Bool] = [false, true, false] // [카드존에 있냐?, 카드덱에 있냐?, 논의중이냐?]
    @Published var isCardBox: Bool = true
    @Published var isCardDeck: Bool = true
    
    @Published var topic = ""
    @Published var currentCardIndex = 0
    @Published var topicSuggestion: Topic?
    
    @Published var viewStateHeight: CGFloat = 0
    
    init() {
        fetchTopicSuggestion()
    }
    
    func storeTopicSuggestion() {
        guard let _ = FirebaseManager.shared.currentUser?.uid else { return }
        guard let roomId = FirebaseManager.shared.roomId else { return }
        
        let topicData = [
            FirebaseConstants.topic: self.topic,
            FirebaseConstants.currentCardIndex: self.currentCardIndex,
            FirebaseConstants.isCardDeck: self.isCardDeck,
            FirebaseConstants.isOnCardZone: self.FinishTopicViewCondition[0],
            FirebaseConstants.isOnCardDeck: self.FinishTopicViewCondition[1],
            FirebaseConstants.underDiscussion: self.FinishTopicViewCondition[2],
            FirebaseConstants.viewStateHeight: self.viewStateHeight
        ] as [String : Any]
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.topics)
            .document(self.topic)
            .setData(topicData) { error in
                if let error = error {
                    print("Failed to store topic information: \(error)")
                    return
                }
                
                print("Successfully stored topic information")
                
                self.fetchTopicSuggestion()
            }
    }
    
    func fetchTopicSuggestion() {
        guard let _ = FirebaseManager.shared.currentUser?.uid else { return }
        guard let roomId = FirebaseManager.shared.roomId else { return }
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.topics)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Failed to listen for new topic: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    print("변화가 있냐!!")
                    self.topicSuggestion = try? change.document.data(as: Topic.self)
                    
                    print("\(roomId)")
                    let topicCondition = [self.topicSuggestion?.isOnCardZone ?? false, self.topicSuggestion?.isOnCardDeck ?? true, self.topicSuggestion?.underDiscussion ?? false]
                    self.FinishTopicViewCondition = topicCondition
                    self.isCardDeck = self.topicSuggestion?.isCardDeck ?? true
                    FirebaseManager.shared.topic = self.topicSuggestion
                    
                    print("Successfully observed the change of topic: \(self.topicSuggestion)")
                    print(">>> \(self.topicSuggestion?.viewStateHeight)")
                    print("<<<< \(self.topicSuggestion?.currentCardIndex)")
                })
            }
    }
}
