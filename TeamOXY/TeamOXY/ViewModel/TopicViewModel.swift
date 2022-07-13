//
//  TopicViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/07/12.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewViewModel: ObservableObject {
    @Published var topics: [Topic] = []

    // 토픽들을 불러온다.
    func fetchTopics(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.topics)
            .whereField("roomId", isEqualTo: roomId)
            .addSnapshotListener { (querySnapshot, _) in
                guard let documents = querySnapshot?.documents else {
                    print("no documents")
                    return
                }
                self.topics = documents.compactMap { (queryDocumentSnapshot) -> Topic? in
                    return try? queryDocumentSnapshot.data(as: Topic.self)
                }
        }
    }
}

