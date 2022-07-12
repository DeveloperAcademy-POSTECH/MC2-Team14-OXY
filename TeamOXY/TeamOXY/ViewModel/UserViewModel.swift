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
    
    func anonymousLogin(roomId: String?, nickname: String) {
        FirebaseManager.shared.auth.signInAnonymously { result, error in
            if let error = error {
                print("Failed to Anonymous login user: \(error)")
                return
            }
            
            print("Successfully logged in user: \(result?.user.uid ?? "")")
        }
    }
    
    func storeUserInformation(roomId: String, nickname: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let userData = [
            FirebaseConstants.uid: uid,
            FirebaseConstants.nickname: nickname
        ]
        
        joinRoom(roomId: roomId, uid: uid, userData: userData)
    }
    
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
    
    private func joinRoom(roomId: String, uid: String, userData: [String: Any]) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.users)
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    print("Failed to store user information: \(error)")
                    return
                }
                
                print("Succeessfully stored user information")
            }
    }
}
