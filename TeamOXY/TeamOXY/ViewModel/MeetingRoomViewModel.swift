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

    @Published var roomId = ""
    
    @Published var currentUser: User?
    @Published var users = [User]()
    
    var errorMessage = ""
    
    func anonymousLogin(scannedCodeUrl: String?, nickname: String) {
        FirebaseManager.shared.auth.signInAnonymously { result, error in
            if let error = error {
                print("Failed to Anonymous login user: \(error)")
                return
            }
            
            print("Successfully logged in user: \(result?.user.uid ?? "")")
            
            self.storeUserInformation(scannedCodeUrl: scannedCodeUrl, nickname: nickname)
        }
    }
    
    func storeUserInformation(scannedCodeUrl: String?, nickname: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let userData = [
            FirebaseConstants.uid: uid,
            FirebaseConstants.nickname: nickname
        ]
        
        // QR code로 입장한 사람
        if let scannedCodeUrl = scannedCodeUrl {
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(scannedCodeUrl)
                .collection(FirebaseConstants.users)
                .document(uid)
                .setData(userData) { error in
                    if let error = error {
                        print("Failed to store user information: \(error)")
                        return
                    }
                    
                    print("Succeessfully stored user information")
                    
                    self.fetchCurrentUser(scannedCodeUrl)
                }
        } else {
            FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(self.roomId)
                .collection(FirebaseConstants.users)
                .document(uid)
                .setData(userData) { error in
                    if let error = error {
                        print("Failed to store user information: \(error)")
                        return
                    }
                    
                    print("Succeessfully stored user information")
                    
                    self.fetchCurrentUser(self.roomId)
                }
        }
    }
    
    func fetchCurrentUser(_ title: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not finde firebase uid"
            print(self.errorMessage)
            return
        }

        roomId = title
        
        // 여기가 두번 처리됨. 그러면서 roomId가 초기화되서 전달됨.
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(title)
            .collection(FirebaseConstants.users)
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user: \(error)"
                    print(self.errorMessage)
                    return
                }
                
                guard let _ = snapshot?.data() else {
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
        guard let _ = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
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
                        
                        return user.id == docId
                    }) {
                        self.users.remove(at: index)
                    }
                    
                    if let rm = try? change.document.data(as: User.self) {
                        self.users.insert(rm, at: 0)
                    }
                    
                    print("Successfully observed documentChange data")
                })
            }
    }
}
