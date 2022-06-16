//
//  CarouselView.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/06/10.
//

import SwiftUI

struct CarouselView: View {
    @ObservedObject var viewModel: CompletionViewModel
    @ObservedObject var emojiViewModel : EmojiViewModel
    
    // gesture 추적
    @GestureState private var dragState = HorizontalDragState.inactive
    @GestureState private var dragState2 = LongPressAndDragState.inactive
    
    @State var viewState = CGSize(width: 0, height: 0) // 가운데 카드 중앙부의 위치
    @State var carouselLocation = 0
    @State var degree = 0.0
    
    var views: [Image]
    var spacerWidth: CGFloat = UIScreen.screenWidth * 0.243
    
    private func onHorizontalDragEnded(drag: DragGesture.Value) {
        let dragThreshold:CGFloat = 100 // 드래그 스레드홀드도 UIScreen으로 해야하나(?)
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold{
            carouselLocation =  carouselLocation - 1
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold)
        {
            carouselLocation =  carouselLocation + 1
        }
    }
    
    var body: some View {
        let minimumLongPressDuration = 0.3
        
        let horizontalDrag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
            }
            .onEnded(onHorizontalDragEnded)
        
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            // 햅틱 추가
            .onChanged{ changeAmount in
                if (dragState2.isActive && !dragState2.isDragging) {
                    HapticManager.instance.impact(style: .medium)
                }
            }
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
                if viewState.height < CarouselViewConstants.secondCardLocation {
                    print("inside zone")
                    viewModel.FinishTopicViewCondition = [true, false, true]
                    viewModel.isCardBox = false
                    
                    // 카드 놓는 곳으로 위치시키기
                    viewState.height = -UIScreen.screenHeight * 0.38// 원래-370
                    
                // 논의중이고 카드존에 없다면
                } else if viewModel.FinishTopicViewCondition[2] == true {
                    // 카드존에 없고, 논의중이 아닐 때, finishTopicView를 띄우고
                    print("not inside zone")
                    viewState.height = -UIScreen.screenHeight * 0.38// 원래 -370
                    viewModel.FinishTopicViewCondition = [false, true, true] // finishTopiceView on
                    viewModel.isCardDeck = false // 카드덱 사라짐
                    
                    // 다시 덱으로 위치시키기
                    self.viewState.height = CarouselViewConstants.initialCardLocation
                } else {
                    // 카드존에 없고, 논의중이 아닐 때 제자리로 돌려보냄
                    print("not inside zone")
                    self.viewState.height = CarouselViewConstants.initialCardLocation
                }
                print("onEnded")
            }
        
        ZStack {
            if viewModel.isCompletion {
                CompletedTopicView()
                    .padding(.bottom, UIScreen.screenHeight * 0.09)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            ZStack(alignment: .bottom){
                // 각각의 요소에 그림자 넣는 법 말고 전체를 묶어서 그림자를 넣는 법 고민해보기
                ForEach(0 ..< views.count, id: \.self){ i in
                    VStack {
                        self.views[i]
                            .resizable()
                            .frame(width: getWidth(i), height: getWidth(i) * 1.4)
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                            .aspectRatio(contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: setShadowColor(i), radius: shadowSetting(i)[0], x: shadowSetting(i)[1], y: shadowSetting(i)[2])
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                            .opacity(self.getOpacity(i))
                            .animation(Animation.easeOut)
                            // offset y를 longpress가 눌리면, 다니 함수의 y값으로 return 하도록 삼항연산자(?)
                            .offset(x: self.getOffsetX(i),
                                    y: setOffsetY(i))
                        // animation은 그 바로 위에 있는 메소드에 적용하는 것, 즉 animation이 3번 반복되는이유는
                        // frame, shadow, offset변화에 애니메이션을 주기 위함 -> 각각에 적용되는 애니메이션이 똑같으면 굳이 그럴필요 있나(?)
                            .scaleEffect(setScale(i))
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                            .blur(radius: setBlur(i))
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    }
                    .zIndex(setZindex(i))
                    // long 프레스와 좌우스크롤은 같은 위계 & 상하 드래그는 long프레스 보다 낮은 위계
                    .simultaneousGesture(
                        // card가 cardzone에 있거나, drag애니메이션2에서 드래깅 중이면 좌우 스크롤 불가
                        isInCardZone() || dragState2.isDragging ? nil : horizontalDrag
                    )
                    .simultaneousGesture(
                        i == relativeLoc() ? longPressDrag : nil)
                }
            
                
                if viewModel.FinishTopicViewCondition == [false, true, true] {
                    VStack{
                        FinishTopicView(viewModel: viewModel)
                            .offset(y: -UIScreen.screenHeight * 0.30)
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                }
                
                EmojiReactionView(viewModel: emojiViewModel)
                    .opacity(isInCardZone() && !dragState2.isDragging ? 1.0 : 0)
                    .zIndex(3)
            }
        }
    }
    
    // center카드가 cardZone에 있는지 확인
    func isInCardZone() -> Bool {
        let curHeight = viewState.height + dragState2.translation.height
        return curHeight < CarouselViewConstants.secondCardLocation
    }
    
    // 스케일세팅
    func setScale(_ i: Int) -> CGFloat {
        if isInCardZone()
            && !dragState2.isDragging
            && i == relativeLoc(){
            return 2.5
        } else if dragState2.isDragging && i == relativeLoc() {
            return 1.3
        }
        else {
            return 1.0
        }
    }
    // blur 세팅
    func setBlur(_ i: Int) -> CGFloat {
        if i == relativeLoc() {
            return 0
        } else if dragState2.isDragging{
            return  1.5
        } else {
            return 0
        }
    }
    
    // ShadowColor 세팅
    func setShadowColor(_ i: Int) -> Color {
        if i == relativeLoc() {
            return Color.ShadowGray.opacity(0.5)
        } else {
            return Color.ShadowGray.opacity(0.8)
        }
    }
    
    // 그림자 세팅
    func shadowSetting(_ i: Int) -> [CGFloat] {
        if i == relativeLoc() {
            if isInCardZone() {
                return [24,3,17]
            } else {
                return [36,3,27]
            }
        } else {
            return [36,3,27]
        }
    }
    
    func setOffsetY(_ i: Int) -> CGFloat {
        // 가운데 있고, long press가 실행되었을 때,
        if  i == relativeLoc() {
            // drag중이면 현재height + 드래그한 위치의height를 더해 터치에 따라 움직이도록
            // drag가 끝났을 때 cardzone에 있다면 -150을 그렇지 않으면 첫 위치로 돌아가도록
            if dragState2.isDragging {
                if viewModel.FinishTopicViewCondition[2] {
                    return viewState.height + 30 + (dragState2.translation.height/1.3)
                } else {
                    return viewState.height + (dragState2.translation.height/1.3)
                }
            } else {
                if isInCardZone() {
                    return -UIScreen.screenHeight * 0.18
                } else {
                    return CarouselViewConstants.initialCardLocation
                }
            }
            
            
//            return dragState2.isDragging ? viewModel.FinishTopicViewCondition[2] ? viewState.height + 30 + (dragState2.translation.height/1.3) : viewState.height + (dragState2.translation.height/1.3)
//            : (isInCardZone() ? -UIScreen.screenHeight * 0.18 : initialCardLocation)
            // uiscreen 자리 원래 -150
        }  else {
            return getOffsetY(i)
        }
    }
    
    // 센터의 zindex 변경
    func setZindex(_ i: Int) -> Double {
        if i == relativeLoc() {
            return 2
        } else if i + 1 == relativeLoc()
                    || i - 1 == relativeLoc(){
            return 1
        } else {
            return 0
        }
    }
    
    // 상대적 위치
    func relativeLoc() -> Int{
        // % : 나머지 연산
        // views.count * 10000 을 넣은 이유는 carousellLocation이 음수가 되는 상황을 막기 위한 것
        return ((views.count * 10000) + carouselLocation) % views.count
    }
    
    // width 설정
    func getWidth(_ i: Int) -> CGFloat {
        if i == relativeLoc(){
            return UIScreen.screenWidth * 0.285 //UIScreen.main.bounds.width / 3.5
        } else {
            return UIScreen.screenWidth * 0.243  // UIScreen.main.bounds.width / 4.1
        }
    }
    
    // 보여지지 않는 요소에 대한 투명도 설정
    func getOpacity(_ i:Int) -> Double{
        // isinzone일 때 relativeLoc만 띄우기 그리고 isdragging일 때는 모든 카드 띄우기
        // isinzone이 아닐 때 : 모두 띄워주기
        // isinzone && isdragging일 때는 모든 카드를 띄우고, isdragging이 아닐 때는 가운데만 띄우기
        
        // condition이 아니게 되면서 바로 1이 되어버림
        if viewModel.FinishTopicViewCondition == [false, true, true]
            && viewModel.isCardDeck == false {
            // 타이머뷰 떴을 때 카드 지우기
            return 0
        } else if viewModel.FinishTopicViewCondition == [false, true, false]
        && viewModel.isCardDeck == false {
            return 0
        } else if isInCardZone() && dragState2.isDragging {
            if i == relativeLoc()
                || i + 1 == relativeLoc()
                || i - 1 == relativeLoc()
                || i + 2 == relativeLoc()
                || i - 2 == relativeLoc()
                || (i + 1) - views.count == relativeLoc()
                || (i - 1) + views.count == relativeLoc()
                || (i + 2) - views.count == relativeLoc()
                || (i - 2) + views.count == relativeLoc()
            {
                return 1
            } else {
                return 0
            }
        } else if isInCardZone() && !dragState2.isDragging {
            if i == relativeLoc() {
                return 1
            } else {
                return 0
            }
        } else if !isInCardZone() {
            if i == relativeLoc()
                || i + 1 == relativeLoc()
                || i - 1 == relativeLoc()
                || i + 2 == relativeLoc()
                || i - 2 == relativeLoc()
                || (i + 1) - views.count == relativeLoc()
                || (i - 1) + views.count == relativeLoc()
                || (i + 2) - views.count == relativeLoc()
                || (i - 2) + views.count == relativeLoc()
            {
                return 1
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func getOffsetY(_ i: Int) -> CGFloat {
        if i == relativeLoc() {
            return -8
        } else {
            return 0
        }
    }
    
    func getOffsetX(_ i:Int) -> CGFloat{
        //This sets up the central offset
        if (i) == relativeLoc()
        {
            //Set offset of cental
            //dragState.translation.width는 드래그하는 순간 움직인 거리의 width를 더해줌으로써 움직이는 것처럼 보이게 하기 위함
            return self.dragState.translation.width
        }
        //These set up the offset +/- 1
        else if
            (i) == relativeLoc() + 1
                ||
                (relativeLoc() == views.count - 1 && i == 0)
        {
            //Set offset +1
            return self.dragState.translation.width + (100)
        }
        else if
            (i) == relativeLoc() - 1
                ||
                (relativeLoc() == 0 && (i) == views.count - 1)
        {
            //Set offset -1
            return self.dragState.translation.width - (100)
        }
        //These set up the offset +/- 2
        else if
            (i) == relativeLoc() + 2
                ||
                (relativeLoc() == views.count-1 && i == 1)
                ||
                (relativeLoc() == views.count-2 && i == 0)
        {
            return self.dragState.translation.width + (2*(100))
        }
        else if
            (i) == relativeLoc() - 2
                ||
                (relativeLoc() == 1 && i == views.count-1)
                ||
                (relativeLoc() == 0 && i == views.count-2)
        {
            //Set offset -2
            return self.dragState.translation.width - (2*(100))
        }
        //These set up the offset +/- 3
        else if
            (i) == relativeLoc() + 3
                ||
                (relativeLoc() == views.count-1 && i == 2)
                ||
                (relativeLoc() == views.count-2 && i == 1)
                ||
                (relativeLoc() == views.count-3 && i == 0)
        {
            return self.dragState.translation.width + (3*(100))
        }
        else if
            (i) == relativeLoc() - 3
                ||
                (relativeLoc() == 2 && i == views.count-1)
                ||
                (relativeLoc() == 1 && i == views.count-2)
                ||
                (relativeLoc() == 0 && i == views.count-3)
        {
            //Set offset -2
            return self.dragState.translation.width - (3*(100))
        }
        //This is the remainder
        else {
            return 10000
        }
    }
}

