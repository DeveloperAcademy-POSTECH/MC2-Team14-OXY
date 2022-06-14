//
//  MeetingRoomViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/14.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MeetingRoomViewModel: ObservableObject {
    @Published var roomTitle = ""
    @Published var roomId = ""

    @Published var currentUser: User?
    @Published var users = [User]()
    @Published var errorMessage = ""
    
    func fetchCurrentUser(_ roomId: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not finde firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.users)
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user: \(error)"
                    print(self.errorMessage)
                    return
                }
                
                guard let data = snapshot?.data() else {
                    self.errorMessage = "No data found"
                    print(self.errorMessage)
                    return
                }
                
                self.currentUser = try? snapshot?.data(as: User.self)
                FirebaseManager.shared.currentUser = self.currentUser
                print("Successfully fetch current user")
                
                self.fetchUsers()
            }
    }
    
    func fetchUsers() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(self.roomId)
            .collection(FirebaseConstants.users)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for new user: \(error)"
                    print(self.errorMessage)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    let docId = change.document.documentID
                    
                    if let index = self.users.firstIndex(where: { user in
                        print(user.id ?? "")
                        return "room \(user.id ?? "")" == docId
                    }) {
                        self.users.remove(at: index)
                    }
                    
                    do {
                        if let rm = try? change.document.data(as: User.self) {
                            self.users.insert(rm, at: 0)
                        }
                    } catch {
                        print(error)
                    }
                    
                    print("\(self.currentUser?.nickname ?? "") 방 \(self.users.count)")
                })
            }
    }
}
