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
    
    @Published var isSuggesting: Bool = false
    
    @Published var topic = ""
    @Published var topicSuggestion: Topic?
    
    func storeTopicSuggestion(_ roomId: String) {
        guard let _ = FirebaseManager.shared.currentUser?.uid else { return }
        
        let topicData = [
            FirebaseConstants.topic: self.topic,
            FirebaseConstants.isOnCardZone: self.FinishTopicViewCondition[0],
            FirebaseConstants.isOnCardDeck: self.FinishTopicViewCondition[1],
            FirebaseConstants.underDiscussion: self.FinishTopicViewCondition[2]
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
                
//                self.fetchTopicSuggestion(roomId)
            }
    }
    

}
