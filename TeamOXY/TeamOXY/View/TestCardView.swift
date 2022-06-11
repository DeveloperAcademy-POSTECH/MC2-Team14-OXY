//
//  CardView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

// TODO: Long Press 카드 선택
// TODO: Drag Gesture 카드 이동 && 확대
// TODO: Drag Gesture 카드 이동 && 축소
// TODO: 여기고치기 지우기

// smallCard: 카드가 덱에 있을 때 크기
//let smallCardWidth: CGFloat = 100
//let smallCardHeight: CGFloat = 150
//// largeCard: 카드가 선택돼서 놓여졌을 때 크기
//let largeCardWidth: CGFloat = 250
//let largeCardHeight: CGFloat = 375
//// cardZone: 카드가 놓여지는 공간 가장 아래 ~ 화면 상단 // 카드 존의 높이고
//let cardZoneHeight: CGFloat = 500
//let cardZonePaddingTop: CGFloat = 125
//// cardDeck: 카드 덱 부분(하단)
//let cardDeckHeight: CGFloat = 200
//// cardZoneHeightOverMiddle: 카드 놓여지는 부분이 화면 중앙을 얼마나 넘어가는지
//let cardZoneHeightOverMiddle: CGFloat = cardZoneHeight - UIScreen.main.bounds.height/2
//// initial 위치는 카드가 덱에 있을 때
//let initialCardLocation: CGFloat = UIScreen.main.bounds.height/2 - 100
//// second 위치는 smallCard가 카드가 놓이는 Zone을 넘어갔을 때 (그래서 smallCardHeight 사용)
//let secondCardLocation: CGFloat = cardZoneHeightOverMiddle - smallCardHeight/2

struct TestCardView: View {
    enum DragState {
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
    
    @GestureState var dragState2 = DragState.inactive
    @State var viewState = CGSize(width: 0, height: initialCardLocation)
    
    // 카드 놓는 공간인지 확인
    func isInCardZone() -> Bool {
        let curHeight = viewState.height + dragState2.translation.height
        return curHeight < secondCardLocation
    }
    
    var body: some View {
        let minimumLongPressDuration = 0.3
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            .updating($dragState2) { value, state, transaction in
                switch value {
                // Long press begins.
                case .first(true):  // long press updating
                    state = .pressing
                // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                }
            }
            .onEnded { value in
                guard case .second(true, let drag?) = value else { return }
                self.viewState.width += 0
                self.viewState.height += drag.translation.height
                
                // 카드 놓는 공간 안에 있다면
                if viewState.height < secondCardLocation {
                    print("inside zone")
                    // 카드 놓는 곳으로 위치시키기
                    // 여기 고치기
                    self.viewState.height = -largeCardHeight/2 + cardZoneHeightOverMiddle
                } else {
                    print("not inside zone")
                    // 다시 덱으로 위치시키기
                    self.viewState.height = initialCardLocation
                }
                print("onEnded")
            }
        
        return TempCardView()
                // 테두리
                .overlay {
                    // 카드 놓는 곳으로 가면
                    if isInCardZone() {
                        if dragState2.isDragging {
                            // 빨간색
                            Rectangle()
                                .stroke(.red, lineWidth: 3)
                        }
                    } else {
                        // 그 이외는 다 흰색
                        if dragState2.isDragging {
                            Rectangle()
                                .stroke(.white, lineWidth: 2)
                        }
                    }
                }
                // 크기 조정
                .scaleEffect((viewState.height + dragState2.translation.height < 0 && !dragState2.isDragging) ? 2.5 : 1)
                .animation(.easeInOut)
                // 위치 설정
                .offset(
                    // 가로는 고정
                    x: viewState.width,
                    // 세로는 드래그를 멈추는 위치에 따라
                    // 드래그 하지 않았을 때 카드존에 있으면 지정된 위치로 보내고 아니면 원래 위치로 가라
                    //
                    y: !dragState2.isDragging ? (isInCardZone() ? -largeCardHeight/2 + cardZoneHeightOverMiddle : initialCardLocation) : viewState.height + dragState2.translation.height
                )
                .shadow(radius: dragState2.isActive ? 8 : 0)
               
                .gesture(longPressDrag)
    }
}

struct TestCardView_Previews: PreviewProvider {
    static var previews: some View {
        TestCardView()
    }
}
