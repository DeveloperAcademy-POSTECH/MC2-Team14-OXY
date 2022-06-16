//
//  MeetingRoomViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/14.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import FirebaseFirestore
import FirebaseFirestoreSwift

class MeetingRoomViewModel: ObservableObject {
    @Published var roomId = ""
    @Published var currentUser: User?
    @Published var users = [User]()
    @Published var fcmToken = ""
    
    @Published var currentTimer: TimeModel?
    @Published var isTimerAvailable = true
    
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
        
//        Messaging.messaging().token { token, error in
//            if let error = error {
//                print("Error fetching FCM registration token: \(error)")
//                return
//            }
//            guard let token = token else { return }
//            print("FCM registration token: \(token)")
//            self.fcmToken = token
        
            self.fcmToken = TokenModel.shared.token ?? ""
            
            let userData = [
                FirebaseConstants.uid: uid,
                FirebaseConstants.nickname: nickname,
                FirebaseConstants.fcmToken: self.fcmToken
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
                        self.fetchTimer(roomId: scannedCodeUrl)
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
                        self.storeTimer()
                    }
            }
//        }
    }
    
    func fetchCurrentUser(_ title: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not finde firebase uid")
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
                    print("Failed to fetch current user: \(error)")
                    return
                }
                
                guard let _ = snapshot?.data() else {
                    print("No data found")
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
                    print("Failed to listen for new user: \(error)")
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
    
    func storeTimer() {
        
        let timerData = [
            "timestamp": 0,
            "setTime": Date(),
            "isAvailable": true
        ] as [String : Any]
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(self.roomId)
            .collection(FirebaseConstants.timers)
            .document("timer")
            .setData(timerData) { error in
                if let error = error {
                    print("Failed to store timer information: \(error)")
                    return
                }
                
                print("Succeessfully stored timer information")
                
                self.fetchTimer(roomId: self.roomId)
            }
    }
    
    // 타이머 컬렉션 생성 및 초기화
    func fetchTimer(roomId: String?) {

        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(self.roomId)
            .collection(FirebaseConstants.timers)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Failed to listen for new timer: \(error)")
                    return
                }
                
                print("변경 감지")
                
                // 변경 감지 시 실행될 부분
                let change = querySnapshot?.documentChanges[0]
                print(change)

                if let rm = try? change?.document.data(as: TimeModel.self) {
                    self.currentTimer = rm
                    print("rm: \(rm.timestamp)")
//                    self.isTimerAvailable = rm.isAvailable
                }
                
                // 타이머 설정
                // 끝
            }
    }
    
    // 타이머 설정(업데이트)
    func updateTimer(countTo: Int) {
        print("roomId in updateTimetr: \(self.roomId)")

        print("updateTimer!!!!!!!!!!")
        print("countTo: \(countTo)")
        print("!!!!!!!!!!")
        
        
//
//        let timerUpdate = FirebaseManager.shared.firestore
//                .collection(FirebaseConstants.rooms)
//                .document(self.roomId)
//                .collection(FirebaseConstants.timers)
//                .document("timer")
        
        let timerData = [
            "timestamp": countTo,
            "setTime": Date(),
            "isAvailable": false
        ] as [String : Any]
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(self.roomId)
            .collection(FirebaseConstants.timers)
            .document("timer")
            .setData(timerData) { error in
                if let error = error {
                    print("Failed to store timer information: \(error)")
                    return
                }
                
                print("Succeessfully set timer information")
                
//                self.fetchTimer(roomId: self.roomId)
            }
//
//        timerUpdate.updateData([
//            FirebaseConstants.timestamp : countTo,
//            FirebaseConstants.setTime : Date(),
//            FirebaseConstants.isAvailable : false
//        ])
        
    }
}
