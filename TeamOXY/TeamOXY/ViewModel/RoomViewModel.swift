//
//  RoomViewModel.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/07/05.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class RoomViewModel: ObservableObject {
    @Published var meetingRooms: [MeetingRoom]
    @Published var roomCodeList: Set<String>
    @Published var isEnded: Bool // me
    @Published var usersCount = 0

    init() {
        meetingRooms = [MeetingRoom]()
        roomCodeList = Set<String>()
        isEnded = false // 다른 방법을 찾습니다
    }
    
    func storeMeetingRoomInformation(meetingRoom: MeetingRoom) {
        do {
            _ = try FirebaseManager.shared.firestore
                .collection(FirebaseConstants.rooms)
                .document(meetingRoom.roomId)
                .setData(from: meetingRoom)
        } catch {
            print(error)
            return
        }
    }
    
    // 미팅 시작
    func startMeeting(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isStarted": true])
    }
    
    // 누군가 토픽 던짐
    func suggestTopic(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isSuggested": true])
    }
    
    // 토픽을 내림
    func comfirmTopic(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isSuggested": false])
    }
    
    // 토픽에 대한 결과 입력 -> 타이머 설정 (아니요/네)
    func completedSuggestion(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isConfirmed": true])
    }
    
    // 타이머 설정
    func startTimerSetting(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isConfirmed": false, "isSettingTimer": true])
    }
    
    // 타이머 시작
    func startTimer(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isSettingTimer": false, "isStartingTimer": true])
    }
    
    // 타이머 종료
    func completedTimer(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isStartingTimer": false])
    }
    
    
    func deleteMeetingRoom(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .delete() { error in
                if let error = error {
                    print("Error removing document: \(error)")
                    return
                }
                
                print("Document successfully removed!")
            }
    }
}
