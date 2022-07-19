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
    @Published var roomIdList: Set<String>
    @Published var isEnded: Bool // me
    @Published var usersCount = 0

    init() {
        meetingRooms = [MeetingRoom]()
        roomIdList = Set<String>()
        isEnded = false // 다른 방법을 찾습니다
    }
    
    // 방 정보들 불러오기
    func fetchMeetingRooms(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms).whereField("roomId", isEqualTo: "\(roomId)").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no documents")
                    return
                }
                
                self.meetingRooms = documents.compactMap { quertDocumentSnapshot -> MeetingRoom? in
                    return try? quertDocumentSnapshot.data(as: MeetingRoom.self)
                }
            }
    }
    
    // 방정보 파이어스토어에 저장
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
    // --- 방에 들어가면 기본적으로 미팅 시작?
    // -> 1) 방 인원 수 불러오기
    // -> 2) 토픽들 불러오기
    func startMeeting(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isStarted": true])
    }
    
    // 누군가 토픽 던짐
    // -> 1) Topic이 중앙으로 위치하기
    // -> 2) 모두에게 알람이 가기
    // -> 3) 이모지 리액션을 할 수 있게 하기
    func suggestTopic(roomId: String, topicIndex: Int) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isSuggested": true])
        
        TopicViewModel().storeTopicInformation(roomId: roomId, topicIndex: topicIndex)
    }
    
    // 토픽을 내림
    // -> 1) Topic이 원래 위치로 위치하기
    // -> 2) - 직접 토픽을 내린 사람
    // ---------- 토픽에 대한 결과 입력 창이 떠야 함
    //       - 토픽 내린 걸 알게된 사람
    // ---------- 누군가 토픽에 대한 결과 입력 중을 알 수 있는 창이 떠야 함
    func comfirmTopic(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isSuggested": false])
    }
    
    // 토픽에 대한 결과 입력 -> 타이머 설정 (아니요/네)
    // -> 1) 아니요 입력 시
    // -------- 미팅 시작 시점으로 가서 화면 구성
    // -> 2) 네 입력 시
    // -------- 타이머 설정 뷰로 이동
    func completedSuggestion(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isConfirmed": true])
    }
    
    // 타이머 설정
    // -> 1) 토픽에 대한 결과 입력한 사람이 타이머 설정까지 이어짐
    // -------- 타이머 설정 뷰가 떠서 타임 설정
    // -------- 타이머 시작하기 누르면 타이머 뷰로 이동
    // -------- 파이어 스토어에서 타이머를 추가 저장한다.
    // -> 2) 나머지 사람들은 누군가 타이머 설정 중을 알 수 있는 창이 떠야 함
    func startTimerSetting(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isConfirmed": false, "isSettingTimer": true])
    }
    
    // 타이머 시작
    // -> 1) 모두 타이머가 동작하는 뷰를 볼 수 있다.
    // -------- 파이어 스토어에서 타이머를 불러온다.
    // -------- 해당 시간에 맞게 시작한다.
    func startTimer(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isSettingTimer": false, "isStartingTimer": true])
    }
    
    // 타이머 종료
    // -> 1) 모두 타이머가 종료되었다는 알림이 뜬다.
    // -------- 파이어 스토어에서 타이머를 삭제한다.
    // -> 2) 다시 미팅 시작 시점으로 가서 화면 구성
    func completedTimer(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .updateData(["isStartingTimer": false])
    }
    
    // 방 삭제
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
    
    // 룸코드 중복을 위해 fireStore에서 룸코드를 Set으로 가져오는 메소드입니다
    func getRoomCodeList() {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .getDocuments { (querySnapshot, _ ) in
                for document in querySnapshot!.documents {
                    guard let anotherRoomCode = document.data()["roomId"] as? String else {
                        print("No room")
                        return
                    }
                    self.roomIdList.insert(anotherRoomCode)
                }
            }
    }
    
    // 방 인원 수 구하기
    func getUserCount(roomId: String) {
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.rooms)
            .document(roomId)
            .collection(FirebaseConstants.users)
            .getDocuments { querySnapshot, error in
                if error != nil {
                    print("failed to get users data")
                    return
                }
                
                for _ in querySnapshot!.documents {
                    self.usersCount += 1
                }
            }
    }
}
