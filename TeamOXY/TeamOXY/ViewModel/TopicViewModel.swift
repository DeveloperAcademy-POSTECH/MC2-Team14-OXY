//
//  TopicViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/07/12.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = Topic.topicViews
    @Published var currentTopic: Topic?
    
    // 토픽 파이어 스토어 저장
    func storeTopicInformation(roomId: String, topicIndex: Int) {

        let topicData = [
            FirebaseConstants.topic: topicIndex.indexToString,
            FirebaseConstants.currentCardIndex: topicIndex,
            FirebaseConstants.timestamp: Date()
        ] as [String: Any]
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.topics)
            .document(FirebaseConstants.topic)
            .setData(topicData) { error in
                if let error = error {
                    print("Failed to store topic information: \(error)")
                    return
                }
                
                print("Successfully stored topic information")
            }
    }
}

