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

// 횡스크롤 drag gesture
enum HorizontalDragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

// long press & drag gesture
enum LongPressAndDragState {
    case inactive   // no interaction
    case pressing   // long press in progress
    case dragging(translation: CGSize)  // dragging
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .pressing, .dragging:
            return true
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive, .pressing:
            return false
        case .dragging:
            return true
        }
    }
}

// smallCard: 카드가 덱에 있을 때 크기
let smallCardWidth: CGFloat = UIScreen.screenWidth * 0.28
let smallCardHeight: CGFloat =  smallCardWidth * 1.4

// largeCard: 카드가 선택돼서 놓여졌을 때 크기
let largeCardWidth: CGFloat = 250 // 안쓰임
let largeCardHeight: CGFloat = 375 // 안쓰임

// cardZone: 카드가 놓여지는 공간 가장 아래 ~ 화면 상단
let cardZoneHeight: CGFloat =  UIScreen.screenHeight * 0.59 //500
let cardZonePaddingTop: CGFloat = 125 // 안쓰임

// cardZoneHeightOverMiddle: 카드 놓여지는 부분이 화면 중앙을 얼마나 넘어가는지
let cardZoneHeightOverMiddle: CGFloat = cardZoneHeight - UIScreen.screenHeight/2

// initial 위치는 카드가 덱에 있을 때
let initialCardLocation: CGFloat = 0

// second 위치는 smallCard가 카드가 놓이는 Zone을 넘어갔을 때 (그래서 smallCardHeight 사용)
//let secondCardLocation: CGFloat = cardZoneHeightOverMiddle - smallCardHeight/2
let secondCardLocation: CGFloat = -UIScreen.screenHeight * 0.23 //-200
