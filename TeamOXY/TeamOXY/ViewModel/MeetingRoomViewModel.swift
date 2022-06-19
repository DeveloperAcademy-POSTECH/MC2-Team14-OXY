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
    
    @Published var isLogin = false
    
    @Published var currentTimer: TimeModel?
    @Published var isTimerAvailable = false
    
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
            
        self.fcmToken = TokenModel.shared.token ?? ""
        
            let userData = [
                FirebaseConstants.uid: uid,
                FirebaseConstants.nickname: nickname,
                FirebaseConstants.fcmToken: self.fcmToken
            ]
            
            // QR code로 입장한 사람
            if let scannedCodeUrl = scannedCodeUrl {
                self.roomId = scannedCodeUrl
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
                        self.storeTimer()
                    }
            }
            self.fetchCurrentUser(self.roomId)
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
                FirebaseManager.shared.roomId = self.roomId
                
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
                    
                    self.isLogin = true
                })
            }
    }
    
    func storeTimer() {
           
           let timerData = [
               "timestamp": 0,
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
                   print("타이머 변경 감지!")

   //                self.currentUser = try? snapshot?.data(as: User.self)
   //                FirebaseManager.shared.currentUser = self.currentUser
                   
                   let rm = try? change?.document.data(as: TimeModel.self)
                   timerViewModel.shared.currentTimer = rm
                   self.isTimerAvailable = timerViewModel.shared.currentTimer?.isAvailable ?? false
                   
                   print("타이머 뷰모델을 쉐어드에 저장\(timerViewModel.shared.currentTimer?.isAvailable)")
   //                    self.currentTimer = rm
   //                    print("rm: \(rm.timestamp)")
   //                    self.isTimerAvailable = rm.isAvailable
                   
                   
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
               // false -> true
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
       
       func terminateTimer() {
      print("타이머 종료시키기")
           
   //
   //        let timerUpdate = FirebaseManager.shared.firestore
   //                .collection(FirebaseConstants.rooms)
   //                .document(self.roomId)
   //                .collection(FirebaseConstants.timers)
   //                .document("timer")
           
           let timerData = [
               "timestamp": 10,
               "setTime": Date(),
               // false -> true
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
