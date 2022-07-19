//
//  testCarousel.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/07/10.
//

import SwiftUI

struct testCarousel: View {
    @State private var snappedItem = 0.0

    @State private var draggingItem = 0.0
    @ObservedObject var viewModel = CarouselViewModel()
    
    // 초기 제스처 상태: inactive
    @GestureState var dragState = LongPressAndDragState.inactive
    // 초기 카드 위치
    @State var viewState = CGSize(width: 0, height: 0)
    
    @State var viewStates: [CGSize] = []
    
    // 카드 Scale
    @State var cardScale = 1.0
    
    @State var degree = 0.0
    
    // 카드 놓는 공간인지 확인
    func isInCardZone() -> Bool {
        // 현재 위치
        let curHeight = viewState.height + dragState.translation.height
        return curHeight < secondLocation
    }
    
    var body: some View {
        // long press 시간
        let minimumLongPressDuration = 0.2
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
                    print("pressing")
                // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    // drag: drag gesture value (optional)
                    state = .dragging(translation: drag?.translation ?? .zero)
                    print("dragging")
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
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(style: StrokeStyle(lineWidth: 1))
                .frame(width: CarouselViewConstants.smallCardWidth * 2.4, height: CarouselViewConstants.smallCardHeight * 2.4)
                .foregroundColor(.gray.opacity(0.2))
                .overlay(content: {
                    HStack(spacing:0) {
                        Text("카드를 올려")
                            .font(.custom("Pretendard-Light", size: 12))
                        Text(" 쉬는 시간")
                            .font(.custom("Pretendard-Light", size: 12))
                            .foregroundColor(Color.PrimaryBlue)
                        Text("을 제안해보세요")
                            .font(.custom("Pretendard-Light", size: 12))
                    }
                })
                .offset(y: -UIScreen.screenHeight * 0.11)
                .transition(AnyTransition.opacity.animation(.easeInOut))
            
            ForEach(viewModel.topicViews) { topic in
                var tempViewState = CGSize(width: 0, height: 0)
                
                ZStack {
                    Image(topic.topic.topicImageLabel)
                        .resizable()
                        .frame(width: CarouselViewConstants.smallCardWidth * 1.08, height: CarouselViewConstants.smallCardHeight * 1.08)
                        .offset(x: tempViewState.width + dragState.translation.width, y: tempViewState.height + dragState.translation.height)
                        .gesture(LongPressGesture(minimumDuration: minimumLongPressDuration)
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
                                         print("pressing")
                                     // Long press confirmed, dragging may begin.
                                     case .second(true, let drag):
                                         // drag: drag gesture value (optional)
                                         state = .dragging(translation: drag?.translation ?? .zero)
                                         print("dragging")
                                     // Dragging ended or the long press cancelled.
                                     default:
                                         state = .inactive
                                     }
                                 }
                                 .onEnded { value in //  final value of the gesture
                                     
                                     // 값이 없으면 그냥 return
                                     guard case .second(true, let drag?) = value else { return }
                                     
                                     // 좌우는 그대로 두고 위아래로만 움직이기
                                     tempViewState.height += drag.translation.height
                                 })
                }
                .offset(y: UIScreen.screenHeight * 0.5 - CarouselViewConstants.smallCardHeight)
                .offset(x: myXOffset(topic.currentCardIndex))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                        draggingItem = snappedItem + value.translation.width
                }
                .onEnded { value in
                    withAnimation(.spring(response: 0.55, dampingFraction: 2, blendDuration: 0.0)) {
                        draggingItem = snappedItem + value.predictedEndTranslation.width
                        if draggingItem <= -(UIScreen.screenWidth * 0.33) {
                            draggingItem = -(UIScreen.screenWidth * 0.33)
                        } else if draggingItem >= (UIScreen.screenWidth * 0.33) {
                            draggingItem = (UIScreen.screenWidth * 0.33)
                        } else if -(UIScreen.screenWidth * 0.33) < draggingItem &&
                                    draggingItem < -(UIScreen.screenWidth * 0.22) {
                            draggingItem = -(UIScreen.screenWidth * 0.33)
                        } else if UIScreen.screenWidth * 0.22 < draggingItem &&
                                    draggingItem < (UIScreen.screenWidth * 0.33) {
                            draggingItem = UIScreen.screenWidth * 0.33
                        } else if -(UIScreen.screenWidth * 0.22) <= draggingItem &&
                                    draggingItem <= UIScreen.screenWidth * 0.22 {
                            draggingItem = 0
                        }
                        snappedItem = draggingItem
                    }
                }
        )
    }

    func myXOffset(_ item: Int) -> Double {
        return Double(item - 2) * CarouselViewConstants.smallCardWidth * 1.18 + draggingItem
        }
}

struct testCarousel_Previews: PreviewProvider {
    static var previews: some View {
        testCarousel()
    }
}
