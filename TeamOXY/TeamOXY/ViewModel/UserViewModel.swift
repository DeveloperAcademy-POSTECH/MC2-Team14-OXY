//
//  UserViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/07/05.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUser: User?
    @Published var isLogin: Bool = false
    
    // 방에 접속하면 방에 입장한 users 불러오기
    func fetchUsers(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.users)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("no documents")
                    return
                }
                
                self.users = documents.compactMap({ (queryDocumentSanpshot) -> User? in
                    print("\(String(describing: queryDocumentSanpshot.data()["nickname"]))----------------------------")
                    return try? queryDocumentSanpshot.data(as: User.self)
                })
            }
    }

    // 익명 로그인 처리
    func anonymousLogin(roomId: String, nickname: String) {
        FirebaseManager.shared.auth.signInAnonymously { result, error in
            if let error = error {
                print("Failed to Anonymous login user: \(error)")
                return
            }
            
            print("Successfully logged in user: \(result?.user.uid ?? "")")
            self.storeUserInformation(roomId: roomId, nickname: nickname)
        }
    }
    
    // 파이어 스토어에 유저 정보 저장
    private func storeUserInformation(roomId: String, nickname: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let userData = [
            FirebaseConstants.uid: uid,
            FirebaseConstants.nickname: nickname
        ]
        
        // 유저 정보를 저장하고 바로 방에 들어간다.
        joinRoom(roomId: roomId, uid: uid, userData: userData)
    }
    
    // 유저가 방에 들어갔다.
    private func joinRoom(roomId: String, uid: String, userData: [String: Any]) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.users)
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    print("Failed to store user information: \(error)")
                    self.isLogin = false
                    return
                }
                
                print("Succeessfully stored user information")
                self.isLogin = true
            }
    }
    
    // 유저가 방을 나갔다. 방에서 유저 정보 삭제
    func leaveMeetingRoom(roomId: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.users)
            .document(uid)
            .delete() { error in
                if let error = error {
                    print("Failed to delete user: \(error)")
                    return
                }
                
                self.users = self.users.filter({ user in
                    uid != user.uid
                })
                
                print("Successfully delete user information")
            }
    }
    
    // 토픽 던지기
    func suggestTopic(roomId: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.topics)
            .document(uid)
    }
    
    func updateUserRole(roomCode: String, roleId: Int, nickname: String, isSelect: Bool) {
        db.collection("meeting_rooms").document("\(roomCode)").collection("users").document(nickname).updateData(["role_id": isSelect ? roleId : 0])
    }

    func updateMissionProgress(roomCode: String, missionId: Int, nickname: String) {
        print("updateMP called")
        var isChanged = false

        let doc =
        db.collection("meeting_rooms").document(roomCode).collection("users").document(nickname)

        doc.addSnapshotListener { DocumentSnapshot, error in
            guard let document = DocumentSnapshot else {
                print("Error fetching document: \(String(describing: error))")
                return
            }
            guard var data = document["mission_progress"] as? [Bool] else {
                print("uVM updateMProgress doc as bool fail")
                return
            }
            if !isChanged && (data.count > missionId) {
                isChanged = true
                data[missionId].toggle()
                doc.updateData(["mission_progress": data])
            }
        }
    }

    func voteUser(roomCode: String, nickname: String) {
        db.collection("meeting_rooms").document(roomCode).collection("users").document(nickname).updateData(["voted_count": FieldValue.increment(Int64(1))])
    }
    
    func getBestPlayer(roomCode: String) {
        var maxVotedCount: Int = 0
        
        db.collection("meeting_rooms").document(roomCode).collection("users").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }

            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                let data = try? queryDocumentSnapshot.data(as: User.self)
                
                if maxVotedCount < data!.votedCount {
                    maxVotedCount = data!.votedCount
                    self.user = data!
                }
                
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
}
