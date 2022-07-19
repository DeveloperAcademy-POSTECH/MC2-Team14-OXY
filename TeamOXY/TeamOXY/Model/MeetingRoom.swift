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
    var roomId: String
    var users: [String] = []
    var topics: [String] = []
    var reactions: [String] = []
    var isStarted: Bool = false
    var isEnded: Bool = false
    var isSuggested: Bool = false
    var isConfirmed: Bool = false
    var isSettingTimer: Bool = false
    var isStartingTimer: Bool = false
}
