//
//  TestCardView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

// MARK: -임의 설정한 값들
// MARK: 겹치는 변수 이름을 수정하였습니다
// 중요! 카드의 초기 위치는 화면 중간
// 화면 높이
let screenHeight = UIScreen.main.bounds.height
// smallCard: 카드가 덱에 있을 때 크기
let smallCardW: CGFloat = 100
let smallCardH: CGFloat = 150
// largeCard: 카드가 선택돼서 놓여졌을 때 크기
let largeCardW: CGFloat = 250
let largeCardH: CGFloat = 375
// upperZone: 카드가 놓여지는 공간 ~ 화면 상단끝(상단)
let upperZoneHeight: CGFloat = 500
let upperZonePaddingTop: CGFloat = 125
// deckZone: 카드 덱 부분(하단)
let cardDeckHeight: CGFloat = 200
// upperZoneHeightOverMiddle: 카드 놓여지는 부분이 화면 중앙을 얼마나 넘어가는지
let upperZoneHeightOverMiddle: CGFloat = upperZoneHeight - screenHeight/2
// initialCardLocation: 카드가 덱에 있을 때
// 즉, 카드의 중심이 화면 젤 아래로 이동했다가 deckZone의 반 만큼 올라옴 -> deckZone의 중간에 위치
let initialLocation: CGFloat = UIScreen.main.bounds.height/2 - cardDeckHeight/2
// secondCardLocation: 카드가 cardFitZone에 있을 때 == smallCard가 cardFitZone 하단을 넘어가는 기준
// 즉, 카드의 중심이 upperZone 젤 아래에 있다가 smallCard 높이의 반 만큼 올라옴 -> upperZone의 하단에 위치
let secondLocation: CGFloat = upperZoneHeightOverMiddle - smallCardH/2

struct TestCardView: View {
    // GestureState: A property wrapper type that updates a property while the user performs a gesture and resets the property back to its initial state when the gesture ends.
    // 초기 제스처 상태: inactive
    @GestureState var dragState = LongPressAndDragState.inactive
    // 초기 카드 위치
    @State var viewState = CGSize(width: 0, height: initialLocation)
    // 카드 Scale
    @State var cardScale = 1.0
    
    // 카드 놓는 공간인지 확인
    func isInCardZone() -> Bool {
        // 현재 위치
        let curHeight = viewState.height + dragState.translation.height
        return curHeight < secondLocation
    }
    
    var body: some View {
        // long press 시간
        let minimumLongPressDuration = 0.3
        // longPressDrag라는 새로운 제스처 정의
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            // longPress에 sequence 사용하여 drag 연결
            .sequenced(before: DragGesture())
            .onChanged { changeAmount in
                // 카드를 올리고 내리는 중간에 크기를 변경
                if isInCardZone() {
                    cardScale = 2.5
                } else {
                    cardScale = 1.0
                }
            }
            // gesture modifier
            .updating($dragState) { value, state, transaction in
                // currentState(updated state of the gesture), gestureState(previous state of the gesture), transaction(context of the gesture)
                switch value {
                // Long press begins.
                case .first(true):  // long press updating
                    state = .pressing
                // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    // drag: drag gesture value (optional)
                    state = .dragging(translation: drag?.translation ?? .zero)
                // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                }
            }
            .onEnded { value in //  final value of the gesture
                // print(value) ->
                // second(true, Optional(SwiftUI.DragGeture.value(...)))
                
                // 값이 없으면 그냥 return
                guard case .second(true, let drag?) = value else { return }
                
                // 좌우는 그대로 두고 위아래로만 움직이기
                self.viewState.height += drag.translation.height

                // 카드 놓는 공간 안에 있다면
                if viewState.height < secondLocation {
                    // 카드 놓는 곳으로 위치시키기
                    // 카드가 확대된 상태에서 놓여야 하기 때문에 largeCardHeight의 반을 뺌
                    self.viewState.height = upperZoneHeightOverMiddle - largeCardH/2
                } else {
                    // 다시 덱으로 위치시키기
                    self.viewState.height = initialLocation
                }
            }
        
        return ZStack {
            Color(.green)
            VStack {
                Text("Card").font(.system(size: 30))
                    .bold()
            }
        }
        .frame(width: 100, height: 150)
                // 테두리
                .overlay {
                    // 카드 놓는 곳으로 가면
                    if isInCardZone() {
                        if dragState.isDragging {
                            // 빨간색
                            Rectangle()
                                .stroke(.red, lineWidth: 3)
                        }
                    } else {
                        // 다른 위치에서 드래그 시 다 흰색
                        if dragState.isDragging {
                            Rectangle()
                                .stroke(.white, lineWidth: 2)
                        }
                    }
                }
                // 크기 조정
                .scaleEffect(cardScale)
                .animation(.easeInOut, value: cardScale)
                // 위치 설정
                .offset(
                    // 가로는 고정
                    x: viewState.width,
                    // 드래그 중 그 값 그대로 반영
                    // 드래그가 끝난 후 위치는 제스처의 onEnded에서 반영
                    y: viewState.height + dragState.translation.height
                )
                .shadow(radius: dragState.isActive ? 8 : 0)
                .animation(Animation.linear(duration: minimumLongPressDuration), value: dragState.isDragging)
                .gesture(longPressDrag)
    }
}

struct TestCardView_Previews: PreviewProvider {
    static var previews: some View {
        TestCardView()
    }
}
