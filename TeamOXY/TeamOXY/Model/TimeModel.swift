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
    let timestamp: Int
    
    // 타이머 설정 당시 시간
    let setTime: Date
    
    // 타이머 사용가능 여부
    let isAvailable: Bool
}
