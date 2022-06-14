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
}
