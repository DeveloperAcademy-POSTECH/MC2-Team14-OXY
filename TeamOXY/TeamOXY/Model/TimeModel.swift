//
//  Timer.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/16.
//

import Foundation

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TimeModel: Codable, Identifiable {
    @DocumentID var id: String?
    
    // 설정된 쉬는 시간
    let timeStamp: Int
    
    // 타이머 설정 당시 시간
    let setTime: Date
    
    // 타이머 사용가능 여부
    let isAvailable: Bool
}

// MARK: - 타이머 설정
// MARK: - firestore에 저장
    // 타이머는 방마다 하나 있음
        // 현재 시간
        // 설정된 시간
// MARK: - 변화감지 -> 모든 유저들에게 타이머 설정
// MARK: - 뷰가 넘어감
    // isActive
// MARK: - 타이머 실행
    // 알림 on/off 여부
    // 타이머 종료 시간

// MARK: - Firebase 구조
// Rooms (Collection)
    // Room (Document)
        // Users (Collection)
            // User
        // Timer (Document)

// 모두가 감지할 수 있게 하려면


// 방법 1
    // Dummy Data를 넣어놓고
    // TimeSetView에서 BreakTimeView로 넘어갈 때
    // isActive가 켜지는 조건에 timeStamp가 0이면 false, 아니면 true

// 


// 미팅룸에 isActive를 넘어서 계속 넘겨주기
// 그래서 돌아올 때 미팅룸으로 올 수 있게

// 모두가 미팅룸에 들어가고
// 그 순간에 fetchTimer()

// Timer
// 종료 여부
    // 앞에 종료 -> 새로 업데이트
    // 아니면 -> 거절

// Timer가 Collection일 필요??
    // Timer가 document라면
        // 타이머가 설정 가능한지 여부
        // 타이머 시작 시간
        // 타이머 몇초인지
