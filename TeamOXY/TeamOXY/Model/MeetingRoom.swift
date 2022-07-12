//
//  MeetingRoom.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/14.
//

import SwiftUI
import FirebaseFirestoreSwift


struct MeetingRoom: Codable, Identifiable {
    @DocumentID var id: String?
    var users: [String]
    var topics: [String]
    var reactions: [String]
    var roomId: String
    var isStarted: Bool
    var isEnded: Bool
    var isSuggested: Bool
    var isConfirmed: Bool
    var isSettingTimer: Bool
    var isStartingTimer: Bool
}
